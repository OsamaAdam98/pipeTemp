`include "oneSecClock.v"

module digiClock(
    input reset,
    output reg[5:0] seconds = 0,
    output reg[5:0] minuits = 0,
    output reg[4:0] hours = 0,
    output reg[4:0] days = 0,
    output reg[3:0] months = 0,
    output reg pulse = 0);

    wire clk;

    oneSecClock Pulse(clk);

    always@(posedge reset)
    begin
        seconds <= 0;
        minuits <= 0;
        hours <= 0;
        days <= 0;
        months <= 0;
    end

    always@(clk)
    begin

        seconds <= seconds + 1;
        
        if(seconds == 60)
        begin
            seconds <= 0;
            minuits <= minuits + 1;
            pulse <= ~pulse;
        end

        if(minuits == 60)
        begin
            minuits <= 0;
            hours <= hours + 1;
        end

        if(hours == 24)
        begin
            hours <= 0;
            days <= days + 1;
        end

        if(days == 30)
        begin
            days <= 0;
            months <= months + 1;
        end

        if(months == 12)
        begin
            months <= 0;
        end

    end

endmodule