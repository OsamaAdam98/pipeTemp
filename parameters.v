//state machine
`define waiting 2'b00
`define startBit 2'b01
`define dataBits 2'b10
`define stopBit 2'b11

//baud rate selection
`define slowest 3'b000
`define kindaSlow 3'b001
`define slow 3'b010
`define normal 3'b011
`define fastest 3'b100

//sync
`define _115200 87 //115200 baud
`define _1200 8333 //1200 baud
`define _2400 4167 //2400 baud
`define _4800 2083 //4800 baud
`define _9600 1042 //9600 baud
`define clockPeriod 100

//parity
`define noParity 2'b00
`define oddParity 2'b01
`define evenParity 2'b10

//limits
`define alarm 8'h95
`define shutdown 8'hc7