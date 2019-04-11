`include "parameters.v"

module uArtRx (
    input serialInput,
    input clkRx,
    input reset,
    input reg[1:0] baudRate,
    output reg[7:0] data = 0);

    reg[1:0] stateMachine = 0;
    reg[2:0] bitIndex = 0;
    reg validity = 0;
    reg resetreg;
    
    integer clocksPerBit;
    integer clkCount = 0;

    always@(posedge resetreg)
    begin
        stateMachine <= `waiting;
        data <= 0;
        resetreg <= 0;
    end

    always@(posedge clkRx) 
    begin

        resetreg <= reset;

        case(baudRate)
            `slowest: clocksPerBit <= `_1200;
            `kindaSlow: clocksPerBit <= `_2400;
            `slow: clocksPerBit <= `_4800;
            `normal: clocksPerBit <= `_9600;
        endcase

        case(stateMachine)

            `waiting: 
                begin
                    clkCount <= 0;
                    bitIndex <= 0;
                    if(!serialInput) 
                    begin
                        stateMachine <= `startBit;
                    end

                    else 
                    begin
                        stateMachine <= `waiting;
                    end
                end

            `startBit:
                begin
                    if(clkCount == (clocksPerBit - 1)/2) 
                    begin
                        if(!serialInput) 
                        begin
                            validity <= 1;
                            clkCount <= clkCount + 1;
                            stateMachine <= `startBit;
                        end

                        else
                            stateMachine <= `waiting;
                    end
                    if((clkCount == (clocksPerBit -1)) && validity) 
                    begin
                        stateMachine <= `dataBits;
                    end

                    else 
                    begin
                        clkCount <= clkCount + 1;
                        stateMachine <= `startBit;
                    end
                end

            `dataBits:
                begin
                    if(clkCount < clocksPerBit) 
                    begin
                        clkCount <= clkCount + 1;
                    end
                    
                    else 
                    begin
                        clkCount <= 0;
                        data[bitIndex] = serialInput;

                        if(bitIndex < 7) 
                        begin
                            bitIndex = bitIndex + 1;
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
                    if(clkCount < clocksPerBit) 
                    begin
                        clkCount <= clkCount + 1;
                        stateMachine <= `stopBit;
                    end

                    else 
                    begin
                        clkCount <= 0;
                        stateMachine <= `waiting;
                    end
                end
            
            default: stateMachine <= `waiting;

        endcase
    end


endmodule