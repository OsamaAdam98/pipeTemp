`include "parameters.v"

module clockRx(output reg clk = 0);

    always begin
        #periodRx //clock frequency.
        clk = ~clk;
    end

endmodule