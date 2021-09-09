module processador (clock, instruction, barramentoIn, escolhe_processador, barramentoOut, cache);
		input [6:0] instruction;
		input clock;
		input [1:0] escolhe_processador;
		input [10:0] barramentoIn;
		
		output reg [10:0] barramentoOut;
		output reg [5:0] cache = 6'b000000;
		
		// Estados do processador
		localparam invalid 		= 2'b00;
		localparam exclusive 	= 2'b01;
		localparam shared  		= 2'b10;

		localparam read  		= 1'b0; 
		localparam write 		= 1'b1;
		
		// Possiveis operacoes
		localparam read_miss 	= 2'b00;
		localparam invalidate 	= 2'b10;
		localparam empty 			= 2'b11;
		
		reg WriteBack;	
		reg alternaBus;			//receptor
		reg alternaCpu;			//emissor
		reg [1:0] ocorrencias;
		
		wire [1:0] state;
		
		always @(posedge clock) begin
			alternaBus = 0;
			alternaCpu = 0;
			barramentoOut = 11'b00000000000;
			cache[5:4] = state;
			if(instruction[6:5] == escolhe_processador) begin
				alternaCpu 		= 1;
				ocorrencias[1] = instruction[4];	//Seta o Opcode da instructionrução para a requisição
				if(instruction[4] == read && instruction[3] == cache[3] && cache[5:4] != invalid) begin
					//Read Hit
					barramentoOut[3] 		= cache[3];
					barramentoOut[2:0] 	= cache[2:0];
					ocorrencias[0] 		= 1;
				end
				else if(instruction[4] == read) begin
					//Read Miss
					barramentoOut[9:8] 	= escolhe_processador;
					barramentoOut[5:4] 	= read_miss;
					barramentoOut[3] 		= instruction[3];
					alternaCpu 				= 0;
					if(cache[5:4] == exclusive) begin
						barramentoOut[6] 		= cache[3];
						barramentoOut[7] 		= 1;
						barramentoOut[2:0] 	= cache[2:0];
					end
				end
				else if(instruction[4] == write && instruction[3] == cache[3] && cache[5:4] != invalid) begin 
				// Write Hit
					cache[2:0] 		= instruction[2:0];
					ocorrencias[0] = 1;
					if(cache[5:4] == shared) begin
						barramentoOut[9:8] 	= escolhe_processador;
						barramentoOut[5:4] 	= invalidate;
						barramentoOut[3] 		= cache[3];
					end
				end
				else if(instruction[4] == write) begin 
					// Write Miss
					if(cache[5:4] == exclusive) begin // Write miss em state exclusive gera um WriteBack
						barramentoOut[7] 		= 1;
						barramentoOut[6] 		= cache[3];
						barramentoOut[2:0] 	= cache[2:0];
					end
					// Envia invalidate
					ocorrencias[0] 		= 0;
					barramentoOut[9:8] 	= escolhe_processador;
					barramentoOut[5:4] 	= invalidate;
					barramentoOut[3] 		= instruction[3];
					// Escreve valor na cache
					cache[3] 	= instruction[3];
					cache[2:0] 	= instruction[2:0];
				end
			end
			else if(barramentoIn[5:4]!= 2'b00) begin
					if(barramentoIn[5:4] == read_miss && barramentoIn[3] == cache[3] && cache[5:4] != invalid) begin
						if(cache[5:4] == exclusive) begin
							barramentoOut[7] 	= 1;
							barramentoOut[6] 	= cache[3];
						end
						barramentoOut[10] 	= 1;
						barramentoOut[9:8] 	= barramentoIn[9:8];
						barramentoOut[5:4] 	= empty;
						barramentoOut[3] 		= cache[3];
						barramentoOut[2:0] 	= cache[2:0];
						cache[5:4] 				= shared;
			   end
				else if(barramentoIn[5:4] == empty && barramentoOut[9:8] == escolhe_processador) begin
					if(barramentoOut[10] == 1) begin
						cache[5:4] = shared;
					end
					cache[3] 	= barramentoIn[3];
					cache[2:0] 	= barramentoIn[2:0];
				end
			end
		end
		
	MaquinaEstadoCPU maquinaCPU(clock, alternaCpu, cache[5:4], ocorrencias[1], ocorrencias[0], state);
	MaquinaEstadoBUS maquinaBUS(cache[5:4], --, alternaBus, state, WriteBack, --);
endmodule