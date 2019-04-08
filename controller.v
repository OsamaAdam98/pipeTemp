`include "parameters.v"

module controller(
    input[7:0] adc,
    input clk,
    input oneMinClock,
    input reset,
    output reg shutdown = 0,
    output reg alarm = 0,
    output reg[7:0] temperature = 0,
    output reg pulse = 0);

    reg[3:0] clkCount = 0;

    always@(posedge reset)
    begin
        temperature <= 0;
        clkCount <= 0;
        shutdown <= 0;
        alarm <= 0;
    end

    always@(oneMinClock)
    begin
        clkCount <= clkCount + 1;
        if(clkCount == 4'hF)
        begin
            clkCount <= 0;
            pulse <= ~pulse;
            #5
            pulse <= ~pulse;
        end
    end

    always@(posedge pulse)
    begin
        temperature <= adc;
    end

    always@(posedge clk)
    begin
        if(adc > `alarm)
            alarm <= 1;
        else
            alarm <= 0;

        if(adc > `shutdown)
            shutdown <= 1;
        else
            shutdown <= 0;
    end

endmodule