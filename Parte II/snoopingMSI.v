module snoopingMSI(clock, instruction, cache1, cache2, cache3);
	
	input clock;
	input [6:0] instruction;
	output [5:0] cache1;
	output [5:0] cache2;
	output [5:0] cache3;
	wire [10:0] barramentoOut1; 
	wire [10:0] barramentoOut2;
	wire [10:0] barramentoOut3;
	wire [10:0] mem_bus;
	wire [10:0] bus_wire;
	
	processador p1(clock, instruction, bus_wire, 2'b01, barramentoOut1, cache1);
	processador p2(clock, instruction, bus_wire, 2'b10, barramentoOut2, cache2);
	processador p3(clock, instruction, bus_wire, 2'b11, barramentoOut3, cache3);
	mem m(Clock, bus_wire, mem_bus); 
	bus barramento(clock, barramentoOut1, barramentoOut2, barramentoOut3, mem_bus, bus_wire);

endmodule