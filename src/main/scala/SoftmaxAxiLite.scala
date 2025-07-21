import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axilite._
import spinal.lib.fsm._

// AXI-Lite Softmax配置参数
case class SoftmaxAxiLiteConfig(
  dataWidth: Int = 16,      // 数据位宽
  vectorSize: Int = 4,      // 输入向量大小
  fracWidth: Int = 8,       // 小数部分位宽
  axiDataWidth: Int = 32,   // AXI数据位宽
  axiAddrWidth: Int = 12    // AXI地址位宽
) {
  def intWidth = dataWidth - fracWidth
  def softmaxConfig = SoftmaxConfig(dataWidth, vectorSize, fracWidth)
}

// AXI-Lite寄存器地址映射
object SoftmaxAxiLiteRegs {
  def CTRL_REG     = 0x00  // 控制寄存器 [0]: start, [1]: reset, [31]: busy
  def STATUS_REG   = 0x04  // 状态寄存器 [0]: done, [1]: ready
  def INPUT_BASE   = 0x10  // 输入数据基地址 (0x10, 0x14, 0x18, 0x1C)
  def OUTPUT_BASE  = 0x20  // 输出数据基地址 (0x20, 0x24, 0x28, 0x2C)
  
  def inputAddr(i: Int) = INPUT_BASE + i * 4
  def outputAddr(i: Int) = OUTPUT_BASE + i * 4
}

// AXI-Lite Softmax组件
class SoftmaxAxiLite(config: SoftmaxAxiLiteConfig) extends Component {
  val io = new Bundle {
    val axiLite = slave(AxiLite4(config.axiAddrWidth, config.axiDataWidth))
  }

  // 实例化核心Softmax模块
  val softmax = new Softmax(config.softmaxConfig)
  
  // AXI-Lite接口
  val axiLiteCtrl = new AxiLite4SlaveFactory(io.axiLite)
  
  // 内部寄存器
  val inputRegs = Vec(Reg(Bits(config.axiDataWidth bits)), config.vectorSize)
  val outputRegs = Vec(Reg(Bits(config.axiDataWidth bits)), config.vectorSize)
  
  // 控制和状态信号
  val start = RegInit(False)
  val softReset = RegInit(False)
  val busy = RegInit(False)
  val done = RegInit(False)
  
  // 构建控制寄存器
  val ctrlRegRead = Bits(config.axiDataWidth bits)
  ctrlRegRead := Cat(busy.asBits, B(0, 29 bits), softReset.asBits, start.asBits)
  
  // 构建状态寄存器
  val statusRegRead = Bits(config.axiDataWidth bits)
  statusRegRead := Cat(B(0, 30 bits), softmax.io.ready.asBits, done.asBits)
  
  // AXI-Lite寄存器映射
  axiLiteCtrl.drive(start, SoftmaxAxiLiteRegs.CTRL_REG, 0)
  axiLiteCtrl.drive(softReset, SoftmaxAxiLiteRegs.CTRL_REG, 1)
  axiLiteCtrl.read(ctrlRegRead, SoftmaxAxiLiteRegs.CTRL_REG)
  axiLiteCtrl.read(statusRegRead, SoftmaxAxiLiteRegs.STATUS_REG)
  
  // 输入寄存器映射
  for(i <- 0 until config.vectorSize) {
    axiLiteCtrl.driveAndRead(inputRegs(i), SoftmaxAxiLiteRegs.inputAddr(i))
  }
  
  // 输出寄存器映射 (只读)
  for(i <- 0 until config.vectorSize) {
    axiLiteCtrl.read(outputRegs(i), SoftmaxAxiLiteRegs.outputAddr(i))
  }
  
  // 数据格式转换：AXI数据 -> SFix
  def axiToSFix(axiData: Bits): SFix = {
    val sfixValue = SFix(config.intWidth exp, -config.fracWidth exp)
    sfixValue.raw := axiData(config.dataWidth-1 downto 0).asSInt.resized
    sfixValue
  }
  
  // 数据格式转换：UInt -> AXI数据
  def uintToAxi(uintData: UInt): Bits = {
    val axiData = Bits(config.axiDataWidth bits)
    axiData := uintData.asBits.resized
    axiData
  }
  
  // Softmax输入连接
  for(i <- 0 until config.vectorSize) {
    softmax.io.input(i) := axiToSFix(inputRegs(i))
  }
  
  // 控制逻辑状态机
  object ControlState extends SpinalEnum {
    val IDLE, PROCESSING, DONE = newElement()
  }
  
  val controlState = RegInit(ControlState.IDLE)
  val startPulse = RegNext(start) && !start
  
  // 默认信号赋值
  busy := controlState =/= ControlState.IDLE
  done := controlState === ControlState.DONE
  softmax.io.valid_in := False
  
  switch(controlState) {
    is(ControlState.IDLE) {
      when(start && !softReset) {
        controlState := ControlState.PROCESSING
      }
    }
    
    is(ControlState.PROCESSING) {
      when(softmax.io.ready) {
        softmax.io.valid_in := True
      }
      
      when(softmax.io.valid_out) {
        // 复制输出数据到输出寄存器
        for(i <- 0 until config.vectorSize) {
          outputRegs(i) := uintToAxi(softmax.io.output(i))
        }
        controlState := ControlState.DONE
      }
    }
    
    is(ControlState.DONE) {
      when(!start || softReset) {
        controlState := ControlState.IDLE
      }
    }
  }
  
  // 软复位处理
  when(softReset) {
    controlState := ControlState.IDLE
  }
}

// AXI-Lite Softmax顶层模块
class SoftmaxAxiLiteTop extends Component {
  val config = SoftmaxAxiLiteConfig(
    dataWidth = 16,
    vectorSize = 4,
    fracWidth = 8,
    axiDataWidth = 32,
    axiAddrWidth = 12
  )
  
  val io = new Bundle {
    val axiLite = slave(AxiLite4(config.axiAddrWidth, config.axiDataWidth))
  }

  val softmaxAxiLite = new SoftmaxAxiLite(config)
  softmaxAxiLite.io.axiLite <> io.axiLite
}

// Verilog生成对象
object SoftmaxAxiLiteVerilog extends App {
  SpinalVerilog(new SoftmaxAxiLiteTop)
}