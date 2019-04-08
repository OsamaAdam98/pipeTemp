`include "uArtTx.v"
`include "uArtRx.v"
`include "clk.v"
`include "digiClock.v"
`include "controller.v"

module pipeTemp(input[7:0] adc);

    wire[7:0] temp;
    wire[5:0] seconds;
    wire[5:0] minuits;
    wire[4:0] hours;
    wire[4:0] days;
    wire[3:0] months;
    wire[7:0] database;

    reg reset = 0;

    controller ControllerInst(adc, clk, digiClk, reset, shutdown, alarm, temp, pulse);
    digiClock DigiClock(reset, seconds, minuits, hours, days, months, digiClk);
    uArtTx UArtTx(temp, clk, pulse, reset, serial);
    uArtRx UArtRx(serial, clk, reset, database);
    clock Clock(clk);

endmodule