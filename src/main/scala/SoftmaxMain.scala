import spinal.core._

object SoftmaxMain extends App {
  println("Generating Softmax Verilog...")
  
  val config = SpinalConfig(
    targetDirectory = "rtl",
    defaultConfigForClockDomains = ClockDomainConfig(
      resetKind = SYNC,
      resetActiveLevel = LOW
    )
  )
  
  config.generateVerilog(new SoftmaxTop)
  
  println("Verilog generation completed!")
  println("Generated files:")
  println("- rtl/SoftmaxTop.v")
}