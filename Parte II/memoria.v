module memoria(clock, bus, memOut);
  input clock;
  input [8:0] bus;
  output reg [8:0] memOut;

  wire [1:0] state;
  wire [2:0] tag;
  wire [3:0] data;

  assign state = bus[8:7];
  assign tag 	= bus[6:4];
  assign data 	= bus[3:0];

  reg [6:0] memory [0:6];

  initial
  begin
  // inicializar a memoria
  // tags e dados
  end
  
  always @(bus)
	  if(state == 0) 							// readMiss
			memOut <= memory[tag][3:0];
     else if(state == 1)					// writeBack
			memory[tag][3:0] <= data;

endmodule
