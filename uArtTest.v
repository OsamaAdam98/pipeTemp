`include "uArtTx.v"
`include "uArtRx.v"
`include "clk.v"
`include "parameters.v"

module testBench();


    reg activate = 1;
    reg reset = 0; 
    reg[1:0] baudRate = `normal;
    wire[7:0] data;

    uArtTx transmitter(8'h52, clk, activate, reset, baudRate, serial);
    uArtRx receiver(serial, clk, reset, baudRate, data);
    clock pulse(clk);


endmodule