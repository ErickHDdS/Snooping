module MaquinaEstadoBUS(clock, newState, MSI);
	input clock;
	input [1:0] MSI;
	output reg[1:0] newState;
	
	// Estados do processador
	localparam invalid     = 2'b00;
	localparam exclusive   = 2'b01;
	localparam shared      = 2'b10;
	
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
	
	reg [1:0] state, mensage, action;
	
	initial
    state <= 2'b01;
	 
	always@(posedge clock)
		case (state)			
			exclusive: 
				case(MSI)
					write_miss:
						begin
							state <= invalid;
							newState <= 1;
							mensage <= WriteMissForThisBlock;
							action <= WriteBackBlock_AbortMemoryAccess;
							$display("Write-back block; abort memory access");
						end
					read_miss:
						begin
							state <= shared;
							newState <= 1;
							mensage <= ReadMissForThisBlock;
							action <= WriteBackBlock_AbortMemoryAccess;
							$display("Write-back block; abort memory access");
						end
				endcase
				
			shared: 
				case(MSI)
					write_miss:
						begin
							state <= invalid;
							newState <= 0;
							mensage <= WriteMissForThisBlock;
							action <= EmptyAction;
							$display("Write miss for this block");
						end
					read_miss:
						begin
							state <= shared;
							newState <= 0;
							mensage <= CPUReadMiss;
							action <= EmptyAction;
							$display("CPU read miss");
						end
					invalidate:
						begin
							state <= invalid;
							newState <= 0;
							mensage <= InvalidateForThisBlock;
							action <= EmptyAction;
							$display("Invalidate for this block");
						end
				endcase	
		endcase		
endmodule	