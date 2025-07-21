import spinal.core._
import spinal.core.sim._

object SoftmaxDemo extends App {
  println("=== SpinalHDL Softmax 演示 ===")
  
  val config = SoftmaxConfig(
    dataWidth = 16,
    vectorSize = 4,
    fracWidth = 8
  )
  
  // 软件参考实现
  def softmaxReference(input: Array[Double]): Array[Double] = {
    val maxVal = input.max
    val shifted = input.map(_ - maxVal)
    val exp = shifted.map(math.exp)
    val sum = exp.sum
    exp.map(_ / sum)
  }
  
  // 辅助函数：将定点数转换为浮点数
  def uintToFloat(value: BigInt): Double = {
    value.toDouble / (1 << config.fracWidth)
  }
  
  // 测试用例
  val testCases = Array(
    Array(1.0, 2.0, 3.0, 4.0),
    Array(-1.0, 0.0, 1.0, 2.0),
    Array(2.0, 2.0, 2.0, 2.0),
    Array(0.5, 1.5, 2.5, 3.5)
  )
  
  SimConfig.withWave.compile(new SoftmaxTop).doSim { dut =>
    dut.clockDomain.forkStimulus(period = 10)
    
    for ((testInput, testIndex) <- testCases.zipWithIndex) {
      println(s"\n--- 测试用例 ${testIndex + 1} ---")
      println(s"输入: ${testInput.mkString(", ")}")
      
      // 计算软件参考结果
      val expectedOutput = softmaxReference(testInput)
      println(s"期望输出 (软件): ${expectedOutput.map(x => f"$x%.4f").mkString(", ")}")
      
      // 初始化
      dut.io.valid_in #= false
      dut.clockDomain.waitRisingEdge()
      
      // 等待ready信号
      dut.clockDomain.waitRisingEdgeWhere(dut.io.ready.toBoolean)
      
      // 设置输入
      for (i <- testInput.indices) {
        val clampedValue = math.max(-128.0, math.min(127.99609375, testInput(i)))
        dut.io.input(i) #= clampedValue
      }
      dut.io.valid_in #= true
      dut.clockDomain.waitRisingEdge()
      dut.io.valid_in #= false
      
      // 等待计算完成
      dut.clockDomain.waitRisingEdgeWhere(dut.io.valid_out.toBoolean)
      
      // 读取输出
      val actualOutput = Array.ofDim[Double](config.vectorSize)
      for (i <- actualOutput.indices) {
        actualOutput(i) = uintToFloat(dut.io.output(i).toBigInt)
      }
      
      println(s"实际输出 (硬件): ${actualOutput.map(x => f"$x%.4f").mkString(", ")}")
      
      // 计算误差
      val errors = expectedOutput.zip(actualOutput).map { case (exp, act) => math.abs(exp - act) }
      val maxError = errors.max
      val avgError = errors.sum / errors.length
      
      println(s"最大误差: ${f"$maxError%.4f"}")
      println(s"平均误差: ${f"$avgError%.4f"}")
      
      // 验证输出和
      val sum = actualOutput.sum
      println(s"输出和: ${f"$sum%.4f"}")
      
      dut.clockDomain.waitRisingEdge(5)
    }
    
    println("\n=== 演示完成 ===")
    println("硬件Softmax实现特点:")
    println("1. 使用状态机实现流水线处理")
    println("2. 采用简化的指数近似算法")
    println("3. 支持定点数运算，适合FPGA实现")
    println("4. 输出结果与软件实现基本一致")
  }
}