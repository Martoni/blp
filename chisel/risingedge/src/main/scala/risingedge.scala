import chisel3._
import chisel3.util._
import chisel3.Driver

class RisingEdge extends Module {
  val io = IO(new Bundle{
    val sclk = Input(Bool())
    val redge = Output(Bool())
    val fedge = Output(Bool())
  })

  // seems to not work with icarus + cocotb
  def risingedge(x: Bool) = x && !RegNext(x)
  def fallingedge(x: Bool) = !x && RegNext(x)
  // works with icarus + cocotb
  //def risingedge(x: Bool) = x && !RegNext(RegNext(x))
  //def fallingedge(x: Bool) = !x && RegNext(RegNext(x))


  io.redge :=  risingedge(io.sclk)
  io.fedge := fallingedge(io.sclk)
}

object RisingEdge extends App {
  println("****************************")
  println("* Generate verilog sources *")
  println("****************************")
  chisel3.Driver.execute(Array[String](), () => new RisingEdge())
}
