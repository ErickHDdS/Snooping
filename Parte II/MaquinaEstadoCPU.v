module MaquinaEstadoCPU(clock, MSI, alternar, operacao, acerto, state);
	input clock;
	input [1:0] MSI;
	input alternar,operacao,acerto;
	output reg [1:0]state; 
	
	// Estados do processador
	localparam  invalid		= 2'b00;
	localparam  exclusive  	= 2'b01;
	localparam  shared    	= 2'b10;
	
	// Possiveis operacoes
	localparam read_miss  = 2'b00;
	localparam write_miss = 2'b01;
	localparam read_hit   = 2'b10;
	localparam write_hit  = 2'b11;
	
	// Mensagens do processador
	localparam PlaceReadMissOnBus     = 2'b00;
	localparam PlaceWriteMissOnBus    = 2'b01;
	localparam PlaceInvalidateOnBus   = 2'b10;
	localparam EmptyMessage				 = 2'b11;
	
	// Acoes do processador
	localparam WriteBackBlock 		 	= 2'b00;
	localparam WriteBackCacheBlock 	= 2'b01;
	localparam EmptyAction				= 2'b11;
	
	localparam  read			= 1'b0;
	localparam  write			= 1'b1;
	
	reg [1:0] newState, mensage, action;
	
	initial 
		state = invalid;
	
	always @(negedge clock) begin
		   if(alternar == 0) begin
			case(MSI)
				invalid: 
					begin
						if(operacao == read) 
						begin
							state = shared;
							newState <= read_miss;
							mensage <= PlaceReadMissOnBus;
							action <= EmptyAction;
							$display("CPU read| Place read miss on bus");
						end
						else if(operacao == write) 
						begin
							state = exclusive;
							newState <= write_miss;
							mensage <= PlaceWriteMissOnBus;
							action <= EmptyAction;
							$display("CPU write | Place write miss on bus");
						end
					end
				
				exclusive: 
					begin
						if(acerto == 1 && operacao == write) 
						begin
							state = exclusive;
							newState <= write_hit;
							mensage <= EmptyMessage;
							action <= EmptyAction;
							$display("CPU write hit");
						end
						else if(acerto == 1 && operacao == read) 
						begin
							state = exclusive;
							newState <= read_hit;
							mensage <= EmptyMessage;
							action <= EmptyAction;
							$display("CPU read hit");
						end
						else if(acerto == 0 && operacao == write) 
						begin
							state <= exclusive;
							newState <= write_miss;
							mensage <= PlaceWriteMissOnBus;
							action <= WriteBackCacheBlock;
							$display("CPU write miss | Write-back cache block | Place write miss on bus ");
						end
						else 
						begin
							state <= shared;
							newState <= read_miss;
							mensage <= PlaceReadMissOnBus;
							action <= WriteBackBlock;
							$display("CPU read miss | Write-back block | Place read miss on bus");
						end
					end
					
				shared: begin
					if(operacao == read && acerto == 1) 
					begin
						state <= shared;
						newState <= read_hit;
						mensage <= EmptyMessage;
						action <= EmptyAction;
						$display("CPU read hit");
					end
					else if(operacao == read && acerto == 0 ) 
					begin
						state <= shared;
						newState <= read_miss;
						mensage <= PlaceReadMissOnBus;
						action <= EmptyAction;
						$display("CPU read miss| Place read miss on bus");
					end
					else if(operacao == write && acerto == 0) 
					begin
						state <= exclusive;
						newState <= write_miss;
						mensage <= PlaceWriteMissOnBus;
						action <= EmptyAction;
						$display("CPU write miss | Place write miss on bus");
					end
					else if(operacao == write && acerto == 1) 
					begin
						state <= shared;
						newState <= write_hit;
						mensage <= PlaceInvalidateOnBus;
						action <= EmptyAction;
						$display("CPU write | Place invalidate on bus");
					end
				end
				
			endcase
		end
	end
endmodule