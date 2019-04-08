`timescale 1ns/10ps
`include "parameters.v"

module clock(output reg clk = 0);

    always begin
        #(`clockPeriod/2) //clock frequency.
        clk = ~clk;
    end

endmodule