module MaquinaEstadoBUS(alternar, bus, MSIAAAA, state, WriteBack, abortaAcessoMemoria);
	input alternar;
	input [1:0] bus;
	input [1:0] MSIAAAA; 
	output reg [1:0] state; 
	output reg WriteBack, abortaAcessoMemoria;
	
	// Estados do processador
	localparam invalid     = 2'b00;
	localparam exclusive   = 2'b01;
	localparam shared      = 2'b10;
	
	localparam  read		= 1'b0;
	localparam  write		= 1'b1;
	
	// Possiveis operacoes
	localparam read_miss   = 2'b00;
	localparam write_miss  = 2'b01;
	localparam invalidate  = 2'b10;
	
	// Mensagens do processador
	localparam ReadMissForThisBlock     = 2'b00;
	localparam CPUReadMiss   				= 2'b01;
	localparam WriteMissForThisBlock    = 2'b10;
	localparam InvalidateForThisBlock   = 2'b11;
	
	// Acoes do processador
	localparam WriteBackBlock_AbortMemoryAccess  = 1'b0;
	localparam EmptyAction								= 1'b1;
	
	reg [1:0] mensage, action;
	
	always @(bus) begin
		if(alternar == 1) begin
			WriteBack = 0;
			abortaAcessoMemoria = 0;
			state = MSIAAAA;
			case(MSIAAAA) 	 
				exclusive: 
				begin
					state = exclusive;
					if(bus == write_miss) 
					begin
						state = invalid;
						WriteBack = 1;
						abortaAcessoMemoria  = 1;
						mensage <= WriteMissForThisBlock;
						action <= WriteBackBlock_AbortMemoryAccess;
						$display("Write-back block; abort memory access");
					end
					else if (bus == read_miss) 
					begin
						state = shared;
						WriteBack = 1;
						abortaAcessoMemoria = 1;
						mensage <= ReadMissForThisBlock;
						action <= WriteBackBlock_AbortMemoryAccess;
						$display("Write-back block; abort memory access");
					end
				end
				
				shared: 
				begin 
					//write miss e invalidate
					if(bus == write_miss) 
					begin
						state = invalid;
						mensage <= WriteMissForThisBlock;
						action <= EmptyAction;
						$display("Write miss for this block");
					end
					else if (bus == read_miss) 
					begin
						state = shared;
						mensage <= CPUReadMiss;
						action <= EmptyAction;
						$display("CPU read miss");
					end
					else if(bus == invalidate) 
					begin
						state = invalid;
						mensage <= InvalidateForThisBlock;
						action <= EmptyAction;
						$display("Invalidate for this block");
					end
				end
				
				invalid: 
				begin 
					state = invalid;
					mensage <= InvalidateForThisBlock;
					action <= EmptyAction;
					$display("Invalidate for this block");
				end
			endcase
		end
	end

endmodule