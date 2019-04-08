//state machine
`define waiting 2'b00
`define startBit 2'b01
`define dataBits 2'b10
`define stopBit 2'b11

//sync
`define clocksPerBit 87
`define clockPeriod 100

//limits
`define alarm 8'h95
`define shutdown 8'hc7