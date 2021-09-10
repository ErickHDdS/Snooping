module processador(clock, instruction, busWires, cache);

	input clock;
	input [6:0] instruction;
	
	output reg [8:0] busWires;
	output reg [5:0] cache;
	
		// Estados do processador
		localparam invalid 		= 2'b00;
		localparam exclusive 	= 2'b01;
		localparam shared  		= 2'b10;
		
		// Possiveis operacoes
		localparam read_miss 	= 2'b00;
		localparam invalidate 	= 2'b10;
		localparam empty 			= 2'b11;
		
		// Operacoes das instrucoes
		localparam read  		= 1'b0; 
		localparam write 		= 1'b1;
		
		wire [1:0] newState, mensage, action, state;
		
		initial
		begin
			// inicializar alguns valores 
		end
		
		// desenvolver a logica do snooping
	MaquinaEmissora maqE(clock, newState, state, instruction);
	MaquinaReceptora maqR(clock, newState, state, instruction);
endmodule