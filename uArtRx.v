`include "clkRx.v"

module uArtRx (
    input serialinput,
    output reg[7:0] data = 0);

    reg[2:0] stateMachine = 0;
    reg[3:0] clkCount = 0;
    reg[2:0] bitIndex = 0;
    reg previousState = 1;
    reg currentState = 1;

    parameter clocksPerBit = 3'd7;

    //state machine

    parameter waiting = 2'd0;
    parameter startBit = 2'd1;
    parameter dataBits = 2'd2;
    parameter stopBit = 2'd3;

    wire clkRx;

    clockRx clock(clkRx);


    always@(posedge clkRx) begin
        previousState <= currentState;
        currentState <= serialinput;
    end

    always@(negedge clkRx) begin
        case(stateMachine)

            waiting: 
                begin
                    clkCount <= 0;
                    bitIndex <= 0;
                    if(!previousState) begin
                        stateMachine <= startBit;
                    end
                    else begin
                        stateMachine <= waiting;
                    end
                end

            startBit:
                begin
                    if(clkCount == clocksPerBit/2) begin
                        if(!previousState) begin
                            clkCount <= 0;
                            stateMachine <= dataBits;
                        end
                        else begin
                            stateMachine <= waiting;
                        end
                    end
                    else begin
                        clkCount <= clkCount + 1;
                        stateMachine <= startBit;
                    end
                end

            dataBits:
                begin
                    if(clkCount < clocksPerBit) begin
                        clkCount <= clkCount + 1;
                    end
                    else begin
                        clkCount <= 0;
                        data[bitIndex] = previousState;

                        if(bitIndex < 7) begin
                            bitIndex = bitIndex + 1;
                            stateMachine <= dataBits;
                        end
                        else begin
                            bitIndex <= 0;
                            stateMachine <= stopBit;
                        end

                    end
                end

            stopBit:
                begin
                    if(clkCount < clocksPerBit) begin
                        clkCount <= clkCount + 1;
                        stateMachine <= stopBit;
                    end
                    else begin
                        clkCount <= 0;
                        stateMachine <= waiting;
                    end
                end
            
            default: stateMachine <= waiting;

        endcase
    end


endmodule