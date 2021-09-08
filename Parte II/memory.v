module memory #(parameter [1:0] ReadMiss, WriteBack)(bus, q);
  input [8:0] bus;
  output reg [8:0] q;

  wire [1:0] estado;
  wire [2:0] tag;
  wire [3:0] valor;

  assign estado = bus[8:7];
  assign tag = bus[6:4];
  assign valor = bus[3:0];

  // 7 x TTTDDDD 
  // T- Tag    D- Dado a ser escrito
  reg [6:0] memory [0:6];

  initial
	 begin
		memory[0] = 7'b0000001;
		memory[1] = 7'b0010000;
		memory[2] = 7'b0100001;
		memory[3] = 7'b0110010;
		memory[4] = 7'b1000011;
		memory[5] = 7'b1010100;
		memory[6] = 7'b1100101;
	end

  always @(bus)
    if(estado == WriteBack)
      memory[tag][3:0] <= valor;
		
    else if(estado == ReadMiss)
      q <= memory[tag][3:0];

endmodule