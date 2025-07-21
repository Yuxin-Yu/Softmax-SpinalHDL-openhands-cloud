import spinal.core._
import spinal.lib._

// Softmax配置参数
case class SoftmaxConfig(
  dataWidth: Int = 20,      // 增加数据位宽以提高精度
  vectorSize: Int = 4,      // 输入向量大小
  fracWidth: Int = 12       // 增加小数部分位宽以提高精度
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

  // 精确的指数近似函数 - 使用优化的泰勒级数
  def expApprox(x: SFix): UInt = {
    val result = UInt(config.dataWidth bits)
    
    val xRaw = x.raw
    val isNegative = xRaw.msb
    val absXRaw = Mux(isNegative, -xRaw, xRaw).asUInt
    
    // 限制输入范围以避免溢出
    val clampedAbsX = Mux(absXRaw > U(8 << config.fracWidth), U(8 << config.fracWidth), absXRaw)
    
    val one = U(1 << config.fracWidth, config.dataWidth bits)
    val x_scaled = clampedAbsX.resized
    
    // 使用高精度泰勒级数：exp(x) ≈ 1 + x + x²/2! + x³/3! + x⁴/4! + x⁵/5!
    val x_term = x_scaled
    
    // 计算x的幂次，使用更高精度
    val x2 = (x_scaled.resize(config.dataWidth + 4) * x_scaled.resize(config.dataWidth + 4)) >> config.fracWidth
    val x3 = (x2 * x_scaled.resize(config.dataWidth + 4)) >> config.fracWidth
    val x4 = (x3 * x_scaled.resize(config.dataWidth + 4)) >> config.fracWidth
    val x5 = (x4 * x_scaled.resize(config.dataWidth + 4)) >> config.fracWidth
    
    // 计算各项系数 (使用精确的分数)
    val x2_div2 = x2 >> 1                    // x²/2
    val x3_div6 = (x3 * U(683)) >> 12        // x³/6 ≈ x³ * 0.1667 ≈ x³ * 683/4096
    val x4_div24 = (x4 * U(171)) >> 12       // x⁴/24 ≈ x⁴ * 0.0417 ≈ x⁴ * 171/4096
    val x5_div120 = (x5 * U(34)) >> 12       // x⁵/120 ≈ x⁵ * 0.0083 ≈ x⁵ * 34/4096
    
    val expPos = (one.resize(config.dataWidth + 4) + 
                  x_term.resize(config.dataWidth + 4) + 
                  x2_div2.resized + 
                  x3_div6.resized + 
                  x4_div24.resized + 
                  x5_div120.resized).resized
    
    when(isNegative) {
      // 对于负值：exp(x) = 1/exp(-x)
      when(expPos > (one >> 5)) {  // 避免除零
        val reciprocal = (one.resize(config.dataWidth + config.fracWidth) << config.fracWidth) / expPos.resize(config.dataWidth + config.fracWidth)
        result := reciprocal.resized
      } otherwise {
        result := U(1, config.dataWidth bits) // 非常小的值
      }
    } otherwise {
      // 限制最大值以避免溢出
      val maxExp = U((1 << config.dataWidth) - 1, config.dataWidth bits)
      result := Mux(expPos > maxExp.resize(config.dataWidth + 4), maxExp, expPos.resized)
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
        // 改进的除法：使用更高精度的定点除法
        val dividend = expValues(counter.resized).resize(config.dataWidth + config.fracWidth) << config.fracWidth
        val divisor = sumExp.resized.resize(config.dataWidth + config.fracWidth)
        val quotient = dividend / divisor
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
    dataWidth = 20,
    vectorSize = 4,
    fracWidth = 12
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
