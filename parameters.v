parameter clocksPerBit = 3'd7;

//clock

parameter periodRx = 10;
parameter periodTx = (periodRx * 8);

//state machine

parameter waiting = 2'd0;
parameter startBit = 2'd1;
parameter dataBits = 2'd2;
parameter stopBit = 2'd3;