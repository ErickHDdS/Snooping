module snoopingMSI(clock, instruction, cache1, cache2, cache3);	
	input clock;
	input [6:0] instruction;
	output [5:0] cache1;
	output [5:0] cache2;
	output [5:0] cache3;
	
	wire [8:0] busWires;
	wire [8:0] memOut;
	
	processador p1(clock, instruction, busWires, cache1);
	processador p2(clock, instruction, busWires, cache2);
	processador p3(clock, instruction, busWires, cache3);
	memoria mem(clock, busWires, memOut); 
	bus barramento(clock, p1, p2, p3, memOut, busWires);

endmodule