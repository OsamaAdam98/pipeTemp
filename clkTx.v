module clockTx(output reg clk = 0);

    always begin
        #80 //clock frequency.
        clk = ~clk;
    end

endmodule