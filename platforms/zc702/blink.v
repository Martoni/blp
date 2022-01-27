module blink (
    input  clk_i, 
    output led_o
);

localparam MAX = 100_000_000;
// function $clog2() not supported on localparam by ISE
//localparam WIDTH = $clog2(MAX);
localparam WIDTH = 27;

reg [WIDTH-1:0] count = 0;

wire rst_s;
reg ledreg = 1'b0;
rst_gen rst_inst (.clk_i(clk_i), .rst_i(1'b0), .rst_o(rst_s));

reg  [WIDTH-1:0] cpt_s;
wire [WIDTH-1:0] cpt_next_s = cpt_s + 1'b1;

wire end_s = cpt_s == MAX-1;

always @(posedge clk_i) begin
    cpt_s <= (rst_s || end_s) ? {WIDTH{1'b0}} : cpt_next_s;

    if (rst_s)
        ledreg <= 1'b0;
    else if (end_s)
		ledreg <= ~ledreg;
end

assign led_o = ledreg;

endmodule
