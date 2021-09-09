module bus (clock, Barramento1, Barramento2, Barramento3, BarramentoMemoria, BusWire);
	input [10:0] Barramento1;
	input [10:0] Barramento2;
	input [10:0] Barramento3;
	input [10:0] BarramentoMemoria;
	input clock;
	output reg [10:0]BusWire;
		
	always @(clock) begin
		BusWire = 11'b00000000000;
		if(Barramento1[7] == 1 || Barramento1[5:4] != 2'b00)
			BusWire = Barramento1;
		else if(Barramento2[7] == 1 || Barramento2[5:4] != 2'b00)
			BusWire = Barramento2;
		else if(Barramento3[7] == 1 || Barramento3[5:4] != 2'b00)
			BusWire = Barramento3;
		else if(BarramentoMemoria[5:4] != 2'b00)
			BusWire = BarramentoMemoria;
	end
endmodule