import spinal.core._
import spinal.core.sim._
import org.scalatest.funsuite.AnyFunSuite

class SoftmaxTest extends AnyFunSuite {
  
  val config = SoftmaxConfig(
    dataWidth = 16,
    vectorSize = 4,
    fracWidth = 8
  )

  // 辅助函数：将浮点数转换为定点数
  def floatToSFix(value: Double): Double = {
    // 确保值在SFix范围内：-128.0 到 127.99609375
    val clampedValue = math.max(-128.0, math.min(127.99609375, value))
    clampedValue
  }

  // 辅助函数：将定点数转换为浮点数
  def uintToFloat(value: BigInt): Double = {
    value.toDouble / (1 << config.fracWidth)
  }

  // 软件参考实现
  def softmaxReference(input: Array[Double]): Array[Double] = {
    val maxVal = input.max
    val shifted = input.map(_ - maxVal)
    val exp = shifted.map(math.exp)
    val sum = exp.sum
    exp.map(_ / sum)
  }

  test("Softmax basic functionality") {
    SimConfig.withWave.compile(new SoftmaxTop).doSim { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      
      // 测试用例1：简单的输入
      val testInput1 = Array(1.0, 2.0, 3.0, 4.0)
      val expectedOutput1 = softmaxReference(testInput1)
      
      println(s"Test Input 1: ${testInput1.mkString(", ")}")
      println(s"Expected Output 1: ${expectedOutput1.mkString(", ")}")
      
      // 初始化
      dut.io.valid_in #= false
      dut.clockDomain.waitRisingEdge()
      
      // 等待ready信号
      dut.clockDomain.waitRisingEdgeWhere(dut.io.ready.toBoolean)
      
      // 设置输入
      for (i <- testInput1.indices) {
        dut.io.input(i) #= floatToSFix(testInput1(i))
      }
      dut.io.valid_in #= true
      dut.clockDomain.waitRisingEdge()
      dut.io.valid_in #= false
      
      // 等待计算完成
      dut.clockDomain.waitRisingEdgeWhere(dut.io.valid_out.toBoolean)
      
      // 读取输出
      val actualOutput1 = Array.ofDim[Double](config.vectorSize)
      for (i <- actualOutput1.indices) {
        actualOutput1(i) = uintToFloat(dut.io.output(i).toBigInt)
      }
      
      println(s"Actual Output 1: ${actualOutput1.mkString(", ")}")
      
      // 验证输出和约为1（允许一定误差）
      val sum1 = actualOutput1.sum
      println(s"Sum of outputs: $sum1")
      assert(math.abs(sum1 - 1.0) < 0.1, s"Sum should be close to 1.0, but got $sum1")
      
      // 验证输出是单调递增的（对于递增输入）
      for (i <- 1 until actualOutput1.length) {
        assert(actualOutput1(i) >= actualOutput1(i-1), 
               s"Output should be monotonic increasing, but output($i)=${actualOutput1(i)} < output(${i-1})=${actualOutput1(i-1)}")
      }
      
      dut.clockDomain.waitRisingEdge(10)
    }
  }

  test("Softmax with negative values") {
    SimConfig.withWave.compile(new SoftmaxTop).doSim { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      
      // 测试用例2：包含负值的输入
      val testInput2 = Array(-2.0, -1.0, 0.0, 1.0)
      val expectedOutput2 = softmaxReference(testInput2)
      
      println(s"Test Input 2: ${testInput2.mkString(", ")}")
      println(s"Expected Output 2: ${expectedOutput2.mkString(", ")}")
      
      // 初始化
      dut.io.valid_in #= false
      dut.clockDomain.waitRisingEdge()
      
      // 等待ready信号
      dut.clockDomain.waitRisingEdgeWhere(dut.io.ready.toBoolean)
      
      // 设置输入
      for (i <- testInput2.indices) {
        dut.io.input(i) #= floatToSFix(testInput2(i))
      }
      dut.io.valid_in #= true
      dut.clockDomain.waitRisingEdge()
      dut.io.valid_in #= false
      
      // 等待计算完成
      dut.clockDomain.waitRisingEdgeWhere(dut.io.valid_out.toBoolean)
      
      // 读取输出
      val actualOutput2 = Array.ofDim[Double](config.vectorSize)
      for (i <- actualOutput2.indices) {
        actualOutput2(i) = uintToFloat(dut.io.output(i).toBigInt)
      }
      
      println(s"Actual Output 2: ${actualOutput2.mkString(", ")}")
      
      // 验证输出和约为1
      val sum2 = actualOutput2.sum
      println(s"Sum of outputs: $sum2")
      assert(math.abs(sum2 - 1.0) < 0.1, s"Sum should be close to 1.0, but got $sum2")
      
      // 验证所有输出都是非负数（由于硬件近似，可能有些值为0）
      for (i <- actualOutput2.indices) {
        assert(actualOutput2(i) >= 0, s"All outputs should be non-negative, but output($i)=${actualOutput2(i)}")
      }
      
      dut.clockDomain.waitRisingEdge(10)
    }
  }

  test("Softmax with equal values") {
    SimConfig.withWave.compile(new SoftmaxTop).doSim { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      
      // 测试用例3：相等的输入值
      val testInput3 = Array(2.0, 2.0, 2.0, 2.0)
      val expectedOutput3 = softmaxReference(testInput3)
      
      println(s"Test Input 3: ${testInput3.mkString(", ")}")
      println(s"Expected Output 3: ${expectedOutput3.mkString(", ")}")
      
      // 初始化
      dut.io.valid_in #= false
      dut.clockDomain.waitRisingEdge()
      
      // 等待ready信号
      dut.clockDomain.waitRisingEdgeWhere(dut.io.ready.toBoolean)
      
      // 设置输入
      for (i <- testInput3.indices) {
        dut.io.input(i) #= floatToSFix(testInput3(i))
      }
      dut.io.valid_in #= true
      dut.clockDomain.waitRisingEdge()
      dut.io.valid_in #= false
      
      // 等待计算完成
      dut.clockDomain.waitRisingEdgeWhere(dut.io.valid_out.toBoolean)
      
      // 读取输出
      val actualOutput3 = Array.ofDim[Double](config.vectorSize)
      for (i <- actualOutput3.indices) {
        actualOutput3(i) = uintToFloat(dut.io.output(i).toBigInt)
      }
      
      println(s"Actual Output 3: ${actualOutput3.mkString(", ")}")
      
      // 验证输出和约为1
      val sum3 = actualOutput3.sum
      println(s"Sum of outputs: $sum3")
      assert(math.abs(sum3 - 1.0) < 0.1, s"Sum should be close to 1.0, but got $sum3")
      
      // 验证所有输出都大致相等（应该都约为0.25）
      val expectedValue = 1.0 / config.vectorSize
      for (i <- actualOutput3.indices) {
        assert(math.abs(actualOutput3(i) - expectedValue) < 0.1, 
               s"All outputs should be approximately $expectedValue, but output($i)=${actualOutput3(i)}")
      }
      
      dut.clockDomain.waitRisingEdge(10)
    }
  }
}