
module clockTx(output reg clk = 0);

    always begin
        #160 //clock frequency.
        clk = ~clk;
    end

endmodule