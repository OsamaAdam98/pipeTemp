`timescale 1us/100ns

module oneSecClock(output reg clk = 0);

    always
    begin
        #1
        clk = ~clk;
    end

endmodule