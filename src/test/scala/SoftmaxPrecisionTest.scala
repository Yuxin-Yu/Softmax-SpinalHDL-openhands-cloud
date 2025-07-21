import spinal.core._
import spinal.core.sim._
import org.scalatest.funsuite.AnyFunSuite

class SoftmaxPrecisionTest extends AnyFunSuite {
  
  val config = SoftmaxConfig(
    dataWidth = 20,
    vectorSize = 4,
    fracWidth = 12
  )

  // 辅助函数：将浮点数转换为定点数
  def floatToSFix(value: Double): Double = {
    val clampedValue = math.max(-128.0, math.min(127.999755859375, value))
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

  // 检查精度到小数点后两位
  def checkPrecisionTo2Decimals(expected: Array[Double], actual: Array[Double]): Boolean = {
    expected.zip(actual).forall { case (exp, act) =>
      val expRounded = math.round(exp * 100.0) / 100.0
      val actRounded = math.round(act * 100.0) / 100.0
      math.abs(expRounded - actRounded) <= 0.01  // 允许1%的误差，即小数点后两位一致
    }
  }

  test("Softmax precision test - 2 decimal places accuracy") {
    SimConfig.withWave.compile(new SoftmaxTop).doSim { dut =>
      dut.clockDomain.forkStimulus(period = 10)
      
      val testCases = Array(
        Array(1.0, 2.0, 3.0, 4.0),
        Array(-2.0, -1.0, 0.0, 1.0),
        Array(0.1, 0.2, 0.3, 0.4),
        Array(-0.5, 0.0, 0.5, 1.0),
        Array(2.0, 2.0, 2.0, 2.0)
      )
      
      var allTestsPassed = true
      
      for ((testInput, testIndex) <- testCases.zipWithIndex) {
        val expectedOutput = softmaxReference(testInput)
        
        println(s"\nTest Case ${testIndex + 1}: ${testInput.mkString(", ")}")
        println(s"Expected Output: ${expectedOutput.map(x => f"$x%.6f").mkString(", ")}")
        
        // 初始化
        dut.io.valid_in #= false
        dut.clockDomain.waitRisingEdge()
        
        // 等待ready信号
        dut.clockDomain.waitRisingEdgeWhere(dut.io.ready.toBoolean)
        
        // 设置输入
        for (i <- testInput.indices) {
          dut.io.input(i) #= floatToSFix(testInput(i))
        }
        
        // 启动计算
        dut.io.valid_in #= true
        dut.clockDomain.waitRisingEdge()
        dut.io.valid_in #= false
        
        // 等待计算完成
        dut.clockDomain.waitRisingEdgeWhere(dut.io.valid_out.toBoolean)
        
        // 读取输出
        val actualOutput = (0 until config.vectorSize).map { i =>
          uintToFloat(dut.io.output(i).toBigInt)
        }.toArray
        
        println(s"Actual Output:   ${actualOutput.map(x => f"$x%.6f").mkString(", ")}")
        
        // 检查精度
        val precisionOk = checkPrecisionTo2Decimals(expectedOutput, actualOutput)
        println(s"2-decimal precision check: ${if (precisionOk) "PASS" else "FAIL"}")
        
        // 显示小数点后两位的比较
        println("2-decimal comparison:")
        for (i <- expectedOutput.indices) {
          val expRounded = math.round(expectedOutput(i) * 100.0) / 100.0
          val actRounded = math.round(actualOutput(i) * 100.0) / 100.0
          println(f"  [$i]: expected=${expRounded}%.2f, actual=${actRounded}%.2f, diff=${math.abs(expRounded - actRounded)}%.3f")
        }
        
        if (!precisionOk) {
          allTestsPassed = false
        }
        
        val sum = actualOutput.sum
        println(f"Sum of outputs: $sum%.6f")
        
        dut.clockDomain.waitRisingEdge(5)
      }
      
      assert(allTestsPassed, "Not all test cases passed the 2-decimal precision check")
    }
  }
}
