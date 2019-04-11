//state machine
`define waiting 2'b00
`define startBit 2'b01
`define dataBits 2'b10
`define stopBit 2'b11

//baud rate selection
`define slowest 2'b00
`define kindaSlow 2'b01
`define slow 2'b10
`define normal 2'b11

//sync
`define _115200 87 //115200 baud
`define _1200 8334 //1200 baud
`define _2400 4167 //2400 baud
`define _4800 2084 //4800 baud
`define _9600 1042 //9600 baud
`define clockPeriod 100

//limits
`define alarm 8'h95
`define shutdown 8'hc7