`include "digiClock.v"

module digiClockTest;

    reg reset = 0;
    wire[5:0] seconds, minuits;
    wire[4:0] hours, days;
    wire[3:0] months;

    digiClock clock(reset, seconds, minuits, hours, days, months);

endmodule