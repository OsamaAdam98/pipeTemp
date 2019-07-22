`timescale 1ns/10ps
`include "parameters.v"

module uArtTx(
    input[7:0] dataInput,
    input clkTx,
    input start,
    input reset,
    input[2:0] baudRateInput,
    input[1:0] parityInput,
    output reg serialOut = 1);

    reg[7:0] data = 0;
    reg[1:0] stateMachine = 0;
    reg[2:0] bitIndex = 0;
    reg[2:0] baudRate = 0;
    reg[1:0] parity = 0;
    reg active = 0;
    reg resetreg = 0;
    
    integer clocksPerBit;
    integer clkCount = 0;


    always@(posedge resetreg)
    begin
        stateMachine <= `waiting;
        data <= 0;
        resetreg <= 0;
    end

    always@(start)
    begin
        active <= start;
    end

    always@(posedge clkTx)
    begin
        baudRate <= baudRateInput;
        parity <= parityInput;
    end

    always@(posedge clkTx) 
    begin

        resetreg <= reset;

        case(baudRate)
            `slowest: clocksPerBit <= `_1200;
            `kindaSlow: clocksPerBit <= `_2400;
            `slow: clocksPerBit <= `_4800;
            `normal: clocksPerBit <= `_9600;
            `fastest: clocksPerBit <= `_115200;
        endcase
        

        case(stateMachine)

            `waiting:
                begin
                    serialOut <= 1;
                    clkCount <= 0;
                    bitIndex <= 0;

                    if(active) 
                    begin
                        data <= dataInput;
                        stateMachine <= `startBit;
                    end

                    else
                        stateMachine <= `waiting;
                end

            `startBit:
                begin
                    case(parity)
                            `noParity: data[7] <= data[7];
                            `oddParity: data[7] <= (data[0] ^ data[1] ^ data[2] ^ data[3] ^ data[4] ^ data[5] ^ data[6]);
                            `evenParity: data[7] <= !(data[0] ^ data[1] ^ data[2] ^ data[3] ^ data[4] ^ data[5] ^ data[6]);
                    endcase
                    
                    serialOut <= 1'b0;
                    if(clkCount < (clocksPerBit - 1)) 
                    begin
                        clkCount <= clkCount + 1;
                        stateMachine <= `startBit;
                    end

                    else 
                    begin
                        clkCount <= 0;
                        stateMachine <= `dataBits;
                    end

                end

            `dataBits:
                begin

                    serialOut <= data[bitIndex];

                    if(clkCount < (clocksPerBit - 1)) 
                    begin
                        clkCount <= clkCount + 1;
                        stateMachine <= `dataBits;
                    end

                    else 
                    begin

                        clkCount <= 0;
                        if(bitIndex < 7) 
                        begin
                            bitIndex <= bitIndex + 1;
                            stateMachine <= `dataBits;
                        end

                        else 
                        begin
                            bitIndex <= 0;
                            stateMachine <= `stopBit;
                        end

                    end

                end

            `stopBit:
                begin
                    serialOut <= 1'b1;

                    if(clkCount < (clocksPerBit - 1)) 
                    begin
                        clkCount <= clkCount + 1;
                        stateMachine <= `stopBit;
                    end

                    else 
                    begin
                        active <= 0;
                        clkCount <= 0;
                        stateMachine <= `waiting;
                    end

                end

        endcase

    end

endmodule