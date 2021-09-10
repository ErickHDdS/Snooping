module bus(clock, processador1, processador2, processador3, memory, busOut);
 
	input clock;
	input [8:0] clock, processador1, processador2, processador3, memory;
	output reg [8:0] busOut;
	
	always@(*)
		if(processador1 != 0)
			busOut <= processador1;
		else if(processador2 != 0)
			busOut <= processador2;
		else if(processador3 != 0)
			busOut <= processador3;
		else
			busOut <= memory;
		
endmodule