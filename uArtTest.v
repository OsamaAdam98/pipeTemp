`include "uArtTx.v"
`include "uArtRx.v"
`include "clk.v"
`timescale 1ns/10ps

module testBench();


    reg activate = 1;
    reg reset = 0; 

    uArtTx transmitter(8'h52, clk, activate, reset, serial);
    uArtRx receiver(serial, clk, reset, data);
    clock pulse(clk);


endmodule