import chisel3._
import chisel3.util._
import chisel3.experimental._

class IBUFDS extends BlackBox(Map("DIFF_TERM" -> "TRUE",
                                  "IOSTANDARD" -> "DEFAULT")) {
  val io = IO(new Bundle {
    val O = Output(Clock())
    val I = Input(Clock())
    val IB = Input(Clock())
  })
}

class Blink extends Module {
  val io = IO(new Bundle {
    val led  = Output(Bool())
  })

  val MAX_COUNT = 100000000

  val count = Counter(MAX_COUNT)

  count.inc()

  io.led := 0.U
  when(count.value <= UInt(MAX_COUNT)/2.U){
    io.led := 1.U
  }
}

class Top extends RawModule {
  val clock_p = IO(Input(Clock()))
  val clock_n = IO(Input(Clock()))
  val led = IO(Output(Bool()))

  val ibufds = Module(new IBUFDS)
  ibufds.io.I := clock_p
  ibufds.io.IB:= clock_n

  val blink = Module(new Blink)
  blink.clock := ibufds.io.O
  led := blink.io.led

}

object TopBlinkDriver extends App {
  chisel3.Driver.execute(args, () => new Top)
}
