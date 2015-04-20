import Chisel._

class ButtonDeb extends Module {
    val io = new Bundle {
        val rst = Bool(INPUT)
        val button_in = Bool(INPUT)
        val button_valid = Bool(OUTPUT)
    }

    val clk_freq = 95000
    val debounce_per_ms = 20
    val MAX_COUNT = (clk_freq * debounce_per_ms) + 1
    val count = Reg(UInt())

    val button_in_s = Reg(Bool())
    val button_in_old = Reg(Bool())

    /* synchronise entry */
    button_in_old := io.button_in
    button_in_s := button_in_old

    io.button_valid := button_in_s
}

object Example {
    def main(args: Array[String]): Unit = {
        chiselMain(args, () => Module(new ButtonDeb()))
    }
}
