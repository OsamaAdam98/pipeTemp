module clockRx(output reg clk = 0);

    always begin
        #10 //clock frequency.
        clk = ~clk;
    end

endmodule