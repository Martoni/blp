import cocotb
import logging
from cocotb.triggers import Timer
from cocotb.result import raise_error
from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.triggers import RisingEdge
from cocotb.triggers import FallingEdge
from cocotb.triggers import ClockCycles

PS = 1
NS = 1000*PS
US = 1000*NS
MS = 1000*US

# 100Mhz
HALF_CLK = 5*NS

@cocotb.coroutine
def reset_dut(reset, duration):
    reset <= 1
    yield Timer(duration)
    reset <= 0
    reset.log.info("Reset complete")

@cocotb.test()
def debounce_test(dut):
    """
        Test debounce
    """
    dut._log.info("Running test!")
    dut._log.info("freq value : {} kHz".format(int(dut.clk_freq)))
    dut._log.info("debounce value : {} ms".format(int(dut.debounce_per_ms)))
    clk_per = (1000000/int(dut.clk_freq))*NS
    dut._log.info("Period clock value : {} ps".format(clk_per))
    clock_thread = cocotb.fork(Clock(dut.clk, clk_per).start())
    dut.rst = 1
    dut.button_in = 0
    DEBOUNCE_PER_MS = int(dut.debounce_per_ms)
    yield reset_dut(dut.rst, DEBOUNCE_PER_MS)
    for i in [0, 1]:
        dut.button_in = 1
        yield Timer(DEBOUNCE_PER_MS * 1 * US)
        dut.button_in = 0
        yield Timer(DEBOUNCE_PER_MS * 1 * US)
        dut.button_in = 1
        yield Timer(DEBOUNCE_PER_MS * 5 * US)
        dut.button_in = 0
        yield Timer(DEBOUNCE_PER_MS * 5 * US)
        dut.button_in = 1
        yield Timer(DEBOUNCE_PER_MS * 8 * US)
        dut.button_in = 0
        yield Timer(DEBOUNCE_PER_MS * 8 * US)
        dut.button_in = 1
        yield Timer(DEBOUNCE_PER_MS * 10 * US)
        dut.button_in = 0
        yield Timer(DEBOUNCE_PER_MS * 10 * US)

        dut.button_in = 1
        yield Timer(DEBOUNCE_PER_MS * 2 * MS)

        # 1 to 0
        dut.button_in = 0;
        yield Timer(DEBOUNCE_PER_MS * 1 * US);
        dut.button_in = 1;
        yield Timer(DEBOUNCE_PER_MS * 1 * US);
        dut.button_in = 0;
        yield Timer(DEBOUNCE_PER_MS * 5 * US);
        dut.button_in = 1;
        yield Timer(DEBOUNCE_PER_MS * 5 * US);
        dut.button_in = 0;
        yield Timer(DEBOUNCE_PER_MS * 8 * US);
        dut.button_in = 1;
        yield Timer(DEBOUNCE_PER_MS * 8 * US);
        dut.button_in = 0;
        yield Timer(DEBOUNCE_PER_MS * 10* US);
        dut.button_in = 1;
        yield Timer(DEBOUNCE_PER_MS * 10* US);
        dut.button_in = 0;
        yield Timer(DEBOUNCE_PER_MS * 2 * MS)

    dut._log.info("Test done")
