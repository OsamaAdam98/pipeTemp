`timescale 1ns/10ps

module clock(output reg clk = 0);

    parameter clockPeriod = 100;

    always begin
        #(clockPeriod/2) //clock frequency.
        clk = ~clk;
    end

endmodule