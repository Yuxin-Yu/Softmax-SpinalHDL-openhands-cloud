import spinal.core._
import spinal.lib._

// Softmax配置参数
case class SoftmaxConfig(
  dataWidth: Int = 16,      // 数据位宽
  vectorSize: Int = 4,      // 输入向量大小
  fracWidth: Int = 8        // 小数部分位宽
) {
  def intWidth = dataWidth - fracWidth
}

// Softmax核心组件
class Softmax(config: SoftmaxConfig) extends Component {
  val io = new Bundle {
    val input = in Vec(SFix(config.intWidth exp, -config.fracWidth exp), config.vectorSize)
    val output = out Vec(UInt(config.dataWidth bits), config.vectorSize)
    val valid_in = in Bool()
    val valid_out = out Bool()
    val ready = out Bool()
  }

  // 状态机定义
  object State extends SpinalEnum {
    val IDLE, FIND_MAX, SUB_MAX, EXP_CALC, SUM_EXP, DIV_CALC, DONE = newElement()
  }

  val state = RegInit(State.IDLE)
  val counter = Reg(UInt(log2Up(config.vectorSize + 1) bits)) init(0)
  
  // 内部寄存器
  val inputReg = Reg(Vec(SFix(config.intWidth exp, -config.fracWidth exp), config.vectorSize))
  val maxValue = Reg(SFix(config.intWidth exp, -config.fracWidth exp))
  val shiftedValues = Reg(Vec(SFix(config.intWidth exp, -config.fracWidth exp), config.vectorSize))
  val expValues = Reg(Vec(UInt(config.dataWidth bits), config.vectorSize))
  val sumExp = Reg(UInt(config.dataWidth + log2Up(config.vectorSize) bits))
  val outputReg = Reg(Vec(UInt(config.dataWidth bits), config.vectorSize))

  // 默认输出
  io.ready := state === State.IDLE
  io.valid_out := state === State.DONE
  io.output := outputReg

  // 指数近似函数 - 使用简化的查找表方法
  def expApprox(x: SFix): UInt = {
    val result = UInt(config.dataWidth bits)
    
    // 简化的指数近似：对于小的x值，exp(x) ≈ 1 + x
    // 对于负值，我们使用 exp(x) = 1/(exp(-x))的近似
    val xRaw = x.raw.asUInt
    val isNegative = x.raw.msb
    val absXRaw = Mux(isNegative, (~xRaw + 1).resized, xRaw)
    
    val term1 = U(1 << config.fracWidth, config.dataWidth bits) // 1.0 in fixed point
    val term2 = absXRaw.resized                                 // x term
    
    when(isNegative) {
      // 对于负值：exp(x) ≈ 1/(1+|x|) ≈ 1-|x| (简化)
      when(absXRaw < (1 << config.fracWidth)) {
        result := (term1 - term2).resized
      } otherwise {
        result := U(1, config.dataWidth bits) // 很小的值
      }
    } otherwise {
      // 对于正值：exp(x) ≈ 1 + x
      result := (term1 + term2).resized
    }
    
    result
  }

  // 状态机逻辑
  switch(state) {
    is(State.IDLE) {
      when(io.valid_in) {
        inputReg := io.input
        counter := 0
        maxValue := io.input(0)
        state := State.FIND_MAX
      }
    }

    is(State.FIND_MAX) {
      when(counter < config.vectorSize - 1) {
        counter := counter + 1
        when(inputReg(counter.resized) > maxValue) {
          maxValue := inputReg(counter.resized)
        }
      } otherwise {
        counter := 0
        state := State.SUB_MAX
      }
    }

    is(State.SUB_MAX) {
      when(counter < config.vectorSize) {
        shiftedValues(counter.resized) := inputReg(counter.resized) - maxValue
        counter := counter + 1
      } otherwise {
        counter := 0
        state := State.EXP_CALC
      }
    }

    is(State.EXP_CALC) {
      when(counter < config.vectorSize) {
        expValues(counter.resized) := expApprox(shiftedValues(counter.resized))
        counter := counter + 1
      } otherwise {
        counter := 0
        sumExp := 0
        state := State.SUM_EXP
      }
    }

    is(State.SUM_EXP) {
      when(counter < config.vectorSize) {
        sumExp := sumExp + expValues(counter.resized).resized
        counter := counter + 1
      } otherwise {
        counter := 0
        state := State.DIV_CALC
      }
    }

    is(State.DIV_CALC) {
      when(counter < config.vectorSize) {
        // 简化的除法：使用移位近似
        val dividend = expValues(counter.resized) << config.fracWidth
        val quotient = dividend / sumExp.resized
        outputReg(counter.resized) := quotient.resized
        counter := counter + 1
      } otherwise {
        state := State.DONE
      }
    }

    is(State.DONE) {
      state := State.IDLE
    }
  }
}

// 顶层模块
class SoftmaxTop extends Component {
  val config = SoftmaxConfig(
    dataWidth = 16,
    vectorSize = 4,
    fracWidth = 8
  )
  
  val io = new Bundle {
    val input = in Vec(SFix(config.intWidth exp, -config.fracWidth exp), config.vectorSize)
    val output = out Vec(UInt(config.dataWidth bits), config.vectorSize)
    val valid_in = in Bool()
    val valid_out = out Bool()
    val ready = out Bool()
  }

  val softmax = new Softmax(config)
  softmax.io.input := io.input
  softmax.io.valid_in := io.valid_in
  
  io.output := softmax.io.output
  io.valid_out := softmax.io.valid_out
  io.ready := softmax.io.ready
}

// Verilog生成对象
object SoftmaxVerilog extends App {
  SpinalVerilog(new SoftmaxTop)
}