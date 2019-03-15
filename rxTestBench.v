`include "uArtRx.v"
`include "clk.v"
`timescale 1ns/10ps

module rxTestBench();

    wire clk; 
    reg serialInput;
    wire[7:0] data;
    integer i = 0;

    clock pulse(clk);
    uArtRx receiver(serialInput, clk, dataOut);
    
    parameter bitPeriod = 8600;

    task transmit; 
    
    input[7:0] data;
    integer i;

        begin
        serialInput <= 0;
        #(bitPeriod);

        for(i = 0; i<8; i = i + 1) begin
            serialInput <= data[i];
            #(bitPeriod);
        end

        serialInput <= 1;
        #(bitPeriod);
        end
    endtask




    initial begin
        @(posedge clk);
        transmit(8'h32);
    end

endmodule