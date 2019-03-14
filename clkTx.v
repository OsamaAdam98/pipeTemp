`include "parameters.v"

module clockTx(output reg clk = 0);

    always begin
        #periodTx //clock frequency.
        clk = ~clk;
    end

endmodule