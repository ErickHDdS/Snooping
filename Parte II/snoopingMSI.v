module SnoopingMSI(clock, instruction, cache1, cache2, cache3);	
	input clock;
	input [6:0] instruction;
	output [5:0] cache1;
	output [5:0] cache2;
	output [5:0] cache3;
	
	wire [8:0] bus;
	wire [8:0] memOut;
	
	processador p1(clock, instruction, bus, cache1);
	processador p2(clock, instruction, bus, cache2);
	processador p3(clock, instruction, bus, cache3);
	memoria mem(clock, bus, memOut); 
	bus barramento(clock, p1, p2, p3, memOut, bus);

endmodule