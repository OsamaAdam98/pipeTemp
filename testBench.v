`include "uArtTx.v"
`include "uArtRx.v"
`include "clk.v"
`timescale 1ns/10ps

module testBench();


    reg activate = 1;    

    uArtTx transmitter(8'h02, clk, activate, serial);
    uArtRx receiver(serial, clk, data);
    clock pulse(clk);


endmodule