`include "uArtTx.v"
`include "uArtRx.v"
`include "clk.v"
`include "parameters.v"

module testBench();


    reg activate = 1;
    reg reset = 0; 
    reg[1:0] baudRate = `normal;
    reg[1:0] parity = `oddParity;

    wire parityError;
    wire[7:0] data;

    uArtTx transmitter(8'b00000111, clk, activate, reset, baudRate, `noParity, serial);
    uArtRx receiver(serial, clk, reset, baudRate, parity, data, parityError);
    clock pulse(clk);


endmodule