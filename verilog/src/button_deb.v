// Author : Fabien Marteau <fabien.marteau@armadeus.com>
// Creation Date : 02/11/2014

module button_deb(
        // sync design
        input    clk,
        input    rst,
        // in-out
        input    button_in,
        output   button_valid);

    //Generics parameters
parameter clk_freq = 95000; // clock frequency in kHz
parameter debounce_per_ms = 20;

//Architecture 

localparam  MAX_COUNT = ((debounce_per_ms * clk_freq)) + 1;

reg aedge;
wire debounced;

reg button_in_s;
reg button_in_old;
reg button_hold;

reg button_valid_s;
integer count;

reg button_in_edge_old;

    // synchronize button_in
    always@(posedge clk, posedge rst)
    begin
        if (rst) begin
            button_in_s <= 1'b0;
            button_in_old <= 1'b0;
        end
        else if(clk)
        begin
            button_in_old <= button_in;
            button_in_s <= button_in_old;
        end
    end

    // detecting edge
    always@(posedge clk, posedge rst)
    begin
        if (rst)
            button_in_edge_old <= 1'b0;
        else if(clk)
        begin
            aedge <= button_in_s ^ button_in_edge_old;
            button_in_edge_old <= button_in_s;
        end
    end

    // counter
    always@(posedge clk, posedge rst)
    begin
        if (rst)
        begin
            count <= (MAX_COUNT - 1);
        end
        else if(clk)
        begin
            if(count < MAX_COUNT)
            begin
                count <= count + 1;
            end
            else if(aedge == 1'b1)
            begin
                count <= 0;
            end
        end
    end

    assign debounced = (count == MAX_COUNT) ? aedge : 1'b0;

    // button commute
    always@(posedge clk, posedge rst)
    begin
        if (rst) begin
            button_hold <= 1'b0;
            button_valid_s <= 1'b0;
        end
        else if(clk)
        begin
            if ((debounced == 1'b1) && (aedge == 1'b1))
                button_hold <= ~button_hold;
            if ((debounced == 1'b1) && (button_hold == 1'b0))
                button_valid_s <= ~button_valid_s;
        end
    end

    assign button_valid = button_valid_s;

endmodule
