`include "uArtTx.v"
`include "uArtRx.v"
`include "clk.v"
`include "digiClock.v"
`include "controller.v"
`include "parameters.v"

module pipeTemp(input[7:0] adc);

    wire[7:0] temp;
    wire[5:0] seconds;
    wire[5:0] minuits;
    wire[4:0] hours;
    wire[4:0] days;
    wire[3:0] months;
    wire[7:0] database;

    reg[2:0] baudRate = `fastest;
    reg[1:0] parity = `oddParity;

    reg reset = 0;

    controller ControllerInst(adc, clk, digiClk, reset, shutdown, alarm, temp, pulse);
    digiClock DigiClock(reset, seconds, minuits, hours, days, months, digiClk);
    uArtTx UArtTx(temp, clk, pulse, reset, baudRate, parity, serial);
    uArtRx UArtRx(serial, clk, reset, baudRate, parity, database, parityError);
    clock Clock(clk);

endmodule