// Author: Fabien Marteau <mail@fabienm.eu
// Creation Date : 14/09/2019


module blink (
    // Horloge
    input clock,
    output led
);

// Icestick clock : 12Mhz
//parameter clock_freq = 12_000_000 // clock frequency
// LicheeTang clock : 24Mhz
parameter clock_freq = 24_000_000 // clock frequency

localparam MAX_COUNT = clock_freq;
localparam MAX_COUNT_UPPER = $clog2(MAX_COUNT) - 1;

reg [MAX_COUNT_UPPER:0] counter;

    always@(posedge clock)
    begin
        if(count < MAX_COUNT/2)
            led <= 1;
        else
            led <= 0;
        if(count >= MAX_COUNT)
            count <= 0;
        else
            count <= count + 1;
    end

endmodule
