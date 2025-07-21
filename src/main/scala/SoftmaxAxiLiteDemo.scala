import spinal.core._
import spinal.core.sim._
import spinal.lib.bus.amba4.axilite.sim._

object SoftmaxAxiLiteDemo extends App {
  println("=== SpinalHDL Softmax AXI-Lite 演示 ===")
  
  val config = SoftmaxAxiLiteConfig(
    dataWidth = 16,
    vectorSize = 4,
    fracWidth = 8,
    axiDataWidth = 32,
    axiAddrWidth = 12
  )
  
  // 软件参考实现
  def softmaxReference(input: Array[Double]): Array[Double] = {
    val maxVal = input.max
    val shifted = input.map(_ - maxVal)
    val exp = shifted.map(math.exp)
    val sum = exp.sum
    exp.map(_ / sum)
  }
  
  // 辅助函数：将浮点数转换为AXI格式的定点数
  def floatToAxiSFix(value: Double): Long = {
    val clampedValue = math.max(-128.0, math.min(127.99609375, value))
    val scaledValue = (clampedValue * (1 << config.fracWidth)).toLong
    if (scaledValue >= 0) {
      scaledValue
    } else {
      (1L << config.dataWidth) + scaledValue
    }
  }
  
  // 辅助函数：将AXI格式转换为浮点数
  def axiToFloat(value: Long): Double = {
    val maskedValue = value & ((1L << config.dataWidth) - 1)
    val signExtended = if ((maskedValue & (1L << (config.dataWidth - 1))) != 0) {
      maskedValue - (1L << config.dataWidth)
    } else {
      maskedValue
    }
    signExtended.toDouble / (1 << config.fracWidth)
  }
  
  // AXI-Lite操作辅助函数
  def axiWrite(axiLite: AxiLite4Driver, addr: Long, data: Long): Unit = {
    axiLite.write(addr, data)
  }

  def axiRead(axiLite: AxiLite4Driver, addr: Long): Long = {
    axiLite.read(addr).toLong
  }

  def waitForCompletion(axiLite: AxiLite4Driver, timeoutCycles: Int = 2000): Boolean = {
    var cycles = 0
    while (cycles < timeoutCycles) {
      val status = axiRead(axiLite, SoftmaxAxiLiteRegs.STATUS_REG)
      if ((status & 0x1) != 0) { // done bit
        return true
      }
      sleep(1)
      cycles += 1
    }
    false
  }
  
  // 测试用例
  val testCases = Array(
    ("基本递增序列", Array(1.0, 2.0, 3.0, 4.0)),
    ("包含负值", Array(-1.0, 0.0, 1.0, 2.0)),
    ("相等值", Array(2.0, 2.0, 2.0, 2.0)),
    ("小数值", Array(0.5, 1.5, 2.5, 3.5)),
    ("大范围值", Array(-5.0, 0.0, 5.0, 10.0))
  )
  
  SimConfig.withWave.compile(new SoftmaxAxiLiteTop).doSim { dut =>
    dut.clockDomain.forkStimulus(period = 10)
    val axiLite = AxiLite4Driver(dut.io.axiLite, dut.clockDomain)
    
    // 等待初始化完成
    dut.clockDomain.waitRisingEdge(20)
    
    println("\n=== AXI-Lite接口信息 ===")
    println(s"AXI数据位宽: ${config.axiDataWidth} bits")
    println(s"AXI地址位宽: ${config.axiAddrWidth} bits")
    println(s"寄存器映射:")
    println(s"  控制寄存器:   0x${SoftmaxAxiLiteRegs.CTRL_REG.toHexString}")
    println(s"  状态寄存器:   0x${SoftmaxAxiLiteRegs.STATUS_REG.toHexString}")
    println(s"  输入寄存器:   0x${SoftmaxAxiLiteRegs.INPUT_BASE.toHexString} - 0x${(SoftmaxAxiLiteRegs.INPUT_BASE + config.vectorSize * 4 - 1).toHexString}")
    println(s"  输出寄存器:   0x${SoftmaxAxiLiteRegs.OUTPUT_BASE.toHexString} - 0x${(SoftmaxAxiLiteRegs.OUTPUT_BASE + config.vectorSize * 4 - 1).toHexString}")
    
    for ((testName, testInput) <- testCases.zipWithIndex) {
      val (name, input) = testName
      println(s"\n--- 测试用例 ${testInput + 1}: $name ---")
      println(s"输入: ${input.mkString(", ")}")
      
      // 计算软件参考结果
      val expectedOutput = softmaxReference(input)
      println(s"期望输出 (软件): ${expectedOutput.map(x => f"$x%.4f").mkString(", ")}")
      
      // 检查初始状态
      val initialStatus = axiRead(axiLite, SoftmaxAxiLiteRegs.STATUS_REG)
      if ((initialStatus & 0x2) == 0) {
        println("警告: 设备未就绪，等待...")
        dut.clockDomain.waitRisingEdge(10)
      }
      
      // 写入输入数据
      println("写入输入数据...")
      for (i <- input.indices) {
        val axiData = floatToAxiSFix(input(i))
        axiWrite(axiLite, SoftmaxAxiLiteRegs.inputAddr(i), axiData)
        println(s"  输入[$i]: ${input(i)} -> 0x${axiData.toHexString}")
      }
      
      // 启动计算
      println("启动计算...")
      axiWrite(axiLite, SoftmaxAxiLiteRegs.CTRL_REG, 0x1) // set start bit
      
      // 监控busy状态
      val startTime = System.currentTimeMillis()
      var busy = true
      var cycleCount = 0
      
      while (busy && cycleCount < 2000) {
        val ctrl = axiRead(axiLite, SoftmaxAxiLiteRegs.CTRL_REG)
        busy = (ctrl & 0x80000000L) != 0 // busy bit
        if (busy) {
          dut.clockDomain.waitRisingEdge(1)
          cycleCount += 1
        }
      }
      
      // 等待计算完成
      val completed = waitForCompletion(axiLite, 100)
      val endTime = System.currentTimeMillis()
      
      if (!completed) {
        println("错误: 计算超时!")
        // 跳过当前测试用例
        axiWrite(axiLite, SoftmaxAxiLiteRegs.CTRL_REG, 0x0)
        dut.clockDomain.waitRisingEdge(5)
      } else {
      
      println(s"计算完成，用时: ${cycleCount} 个时钟周期")
      
      // 读取输出数据
      println("读取输出数据...")
      val actualOutput = Array.ofDim[Double](config.vectorSize)
      for (i <- actualOutput.indices) {
        val axiData = axiRead(axiLite, SoftmaxAxiLiteRegs.outputAddr(i))
        actualOutput(i) = axiToFloat(axiData)
        println(s"  输出[$i]: 0x${axiData.toHexString} -> ${actualOutput(i)}")
      }
      
      println(s"实际输出 (硬件): ${actualOutput.map(x => f"$x%.4f").mkString(", ")}")
      
      // 计算误差
      val errors = expectedOutput.zip(actualOutput).map { case (exp, act) => math.abs(exp - act) }
      val maxError = errors.max
      val avgError = errors.sum / errors.length
      
      println(f"最大误差: $maxError%.4f")
      println(f"平均误差: $avgError%.4f")
      
      // 验证输出和
      val sum = actualOutput.sum
      println(f"输出和: $sum%.4f")
      
      // 性能分析
      val isMonotonic = (1 until actualOutput.length).forall(i => actualOutput(i) >= actualOutput(i-1))
      println(s"单调性检查: ${if (isMonotonic) "通过" else "失败"}")
      
      // 清除start位，准备下一次测试
      axiWrite(axiLite, SoftmaxAxiLiteRegs.CTRL_REG, 0x0)
      dut.clockDomain.waitRisingEdge(5)
      }
    }
    
    println("\n=== AXI-Lite寄存器访问测试 ===")
    
    // 测试寄存器读写
    println("测试输入寄存器读写...")
    val testPattern = 0x12345678L
    axiWrite(axiLite, SoftmaxAxiLiteRegs.inputAddr(0), testPattern)
    val readback = axiRead(axiLite, SoftmaxAxiLiteRegs.inputAddr(0))
    println(s"写入: 0x${testPattern.toHexString}, 读回: 0x${readback.toHexString}")
    println(s"寄存器读写: ${if (readback == testPattern) "通过" else "失败"}")
    
    // 测试软复位功能
    println("\n测试软复位功能...")
    axiWrite(axiLite, SoftmaxAxiLiteRegs.CTRL_REG, 0x2) // set reset bit
    dut.clockDomain.waitRisingEdge(5)
    val statusAfterReset = axiRead(axiLite, SoftmaxAxiLiteRegs.STATUS_REG)
    println(s"复位后状态: 0x${statusAfterReset.toHexString}")
    axiWrite(axiLite, SoftmaxAxiLiteRegs.CTRL_REG, 0x0) // clear reset bit
    
    println("\n=== 演示完成 ===")
    println("AXI-Lite Softmax实现特点:")
    println("1. 标准AXI-Lite接口，易于集成到SoC系统")
    println("2. 寄存器映射清晰，支持CPU直接访问")
    println("3. 支持软复位和状态监控")
    println("4. 异步处理，支持中断驱动模式")
    println("5. 与原始Softmax核心保持相同的计算精度")
  }
}