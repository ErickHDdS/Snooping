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
	
	reg [1:0] state;
	
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
							$display("Write-back block; abort memory access");
						end
					read_miss:
						begin
							state <= shared;
							newState <= 1;
							$display("Write-back block; abort memory access");
						end
				endcase
				
			shared: 
				case(MSI)
					write_miss:
						begin
							state <= invalid;
							newState <= 0;
							$display("Write miss for this block");
						end
					read_miss:
						begin
							state <= shared;
							newState <= 0;
							$display("CPU read miss");
						end
					invalidate:
						begin
							state <= invalid;
							newState <= 0;
							$display("Invalidate for this block");
						end
				endcase	
		endcase		
endmodule	