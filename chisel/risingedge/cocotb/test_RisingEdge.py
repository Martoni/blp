import cocotb
import logging
from cocotb.triggers import Timer
from cocotb.result import raise_error
from cocotb.result import TestError
from cocotb.result import ReturnValue
from cocotb.clock import Clock
from cocotb.triggers import Timer
from cocotb.triggers import RisingEdge
from cocotb.triggers import FallingEdge
from cocotb.triggers import ClockCycles

class RisingEdge(object):
    def __init__(self, dut, clock):
        self._dut = dut
        self._clock_thread = cocotb.fork(clock.start())

    @cocotb.coroutine
    def reset(self):
        short_per = Timer(5, units="ns")
        self._dut.reset <= 1
        self._dut.io_sclk <= 0
        yield short_per
        self._dut.reset <= 0
        yield short_per

@cocotb.test()
def test_rising_edge(dut):
    dut._log.info("Launching RisingEdge test")
    redge = RisingEdge(dut, Clock(dut.clock, 1, "ns")) 
    yield redge.reset()
    cwait = Timer(4, "ns")
    yield FallingEdge(dut.clock)
    for i in range(5):
        dut.io_sclk <= 1
        yield cwait
        dut.io_sclk <= 0
        yield cwait
        
