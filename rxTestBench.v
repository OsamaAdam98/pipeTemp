`include "uArtRx.v"
`include "clkTx.v"

module rxTestBench();

    wire clock;


    uArtRx reciever(clock, dataOut);
    clockTx clkTx(clock);




endmodule