module memoria(clock, bus, memOut);
  input [8:0] bus;
  output reg [8:0] memOut;

  wire [1:0] state;
  wire [2:0] tag;
  wire [3:0] data;

  assign state = bus[8:7];
  assign tag 	= bus[6:4];
  assign data 	= bus[3:0];

  reg [6:0] memory [0:6];

  always @(bus)
    if(state == WriteBack)
      memory[tag][3:0] <= data;
    else if(state == ReadMiss)
      memOut <= memory[tag][3:0];
		
endmodule
