import chisel3._
import chisel3.util._

class ButtonDeb extends Module {
    val io = IO(new Bundle {
        val rst = Input(Bool())
        val button_in = Input(Bool())
        val button_valid = Output(Bool())
    })

    val clk_freq = 95000
    val debounce_per_ms = 20
    val MAX_COUNT = (clk_freq * debounce_per_ms) + 1
    val count = Counter(MAX_COUNT)

    def risingedge(x: Bool) = x && !Reg(next = x)

    // synchronize entry
    val button_in_s = ShiftRegister(io.button_valid, 2)
    // Detect button rising edge
    val rbutton_in = risingedge(button_in_s)

    when(count.value =/= UInt(MAX_COUNT)) {
      count.inc()
    }.otherwise {
      when(rbutton_in) {
        count.value := 0.U
        io.button_valid := button_in_s
      }
    }

}

object TopButtonDeb extends App {
  chisel3.Driver.execute(args, () => new ButtonDeb)
}
