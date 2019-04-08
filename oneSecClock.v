`timescale 1s/100ms

module oneSecClock(output reg clk = 0);

    always
    begin
        #1
        clk = ~clk;
    end

endmodule