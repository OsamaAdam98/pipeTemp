module uArtRx (
    input serialInput,
    input clkRx,
    output reg[7:0] data = 0);

    reg[2:0] stateMachine = 0;
    reg[6:0] clkCount = 0;
    reg[2:0] bitIndex = 0;
    reg validity = 0;
    //reg currentState = 1;
    //reg previousState = 1;

    parameter clocksPerBit = 87;

    //state machine

    parameter waiting = 2'd0;
    parameter startBit = 2'd1;
    parameter dataBits = 2'd2;
    parameter stopBit = 2'd3;
/*
    always@(posedge clkRx) begin
        previousState <= currentState;
        currentState <= serialInput;
    end
*/
    always@(posedge clkRx) begin
        case(stateMachine)

            waiting: 
                begin
                    clkCount <= 0;
                    bitIndex <= 0;
                    if(!serialInput) begin
                        stateMachine <= startBit;
                    end
                    else begin
                        stateMachine <= waiting;
                    end
                end

            startBit:
                begin
                    if(clkCount == (clocksPerBit - 1)/2) begin
                        if(!serialInput) begin
                            validity <= 1;
                            clkCount <= clkCount + 1;
                            stateMachine <= startBit;
                        end
                        else
                            stateMachine <= waiting;
                    end
                    if((clkCount == (clocksPerBit -1)) && validity) begin
                        stateMachine <= dataBits;
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
                        data[bitIndex] = serialInput;

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