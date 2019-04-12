`include "uArtTx.v"
`include "uArtRx.v"
`include "clk.v"
`include "parameters.v"

module testBench();


    reg activate = 1;
    reg reset = 0; 
    reg[2:0] baudRate = `fastest;
    reg[1:0] parity = `oddParity;

    wire parityError;
    wire[7:0] data;

    uArtTx transmitter(8'h75, clk, activate, reset, baudRate, parity, serial);
    uArtRx receiver(serial, clk, reset, baudRate, parity, data, parityError);
    clock pulse(clk);


endmodule