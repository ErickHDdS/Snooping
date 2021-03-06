module MaquinaEstadoCPU(clock, newState, MSI);
	input clock;
	input [1:0] MSI;
	output reg[1:0] newState;
	
	// Estados do processador
	localparam invalid     = 2'b00;
	localparam exclusive   = 2'b01;
	localparam shared      = 2'b10;
	
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

	reg [1:0] state, mensage, action;
	
	initial
    state <= 0;
	 
	always@(posedge clock)
		case (state)
			invalid: 
				case(MSI)
					read_miss, read_hit:
						begin
							state <= shared;
							newState <= read_miss;
							mensage <= PlaceReadMissOnBus;
							action <= EmptyAction;
							$display("CPU read| Place read miss on bus");
						end
					write_miss, write_hit:
						begin
							state <= exclusive;
							newState <= write_miss;
							mensage <= PlaceWriteMissOnBus;
							action <= EmptyAction;
							$display("CPU write | Place write miss on bus");
						end
				endcase
				
			exclusive: 
				case(MSI)
					write_hit: 
						begin
							state <= exclusive;
							newState <= write_hit;
							mensage <= EmptyMessage;
							action <= EmptyAction;
							$display("CPU write hit");
						end
					read_hit:
						begin
							state <= exclusive;
							newState <= read_hit;
							mensage <= EmptyMessage;
							action <= EmptyAction;
							$display("CPU read hit");
						end
					write_miss:
						begin
							state <= exclusive;
							newState <= write_miss;
							mensage <= PlaceWriteMissOnBus;
							action <= WriteBackCacheBlock;
							$display("CPU write miss | Write-back cache block | Place write miss on bus ");
						end
					read_miss:
						begin
							state <= shared;
							newState <= read_miss;
							mensage <= PlaceReadMissOnBus;
							action <= WriteBackBlock;
							$display("CPU read miss | Write-back block | Place read miss on bus");
						end
				endcase
				
			shared: 
				case(MSI)
					read_hit: 
						begin
							state <= shared;
							newState <= read_hit;
							mensage <= EmptyMessage;
							action <= EmptyAction;
							$display("CPU read hit");
						end
					read_miss:
						begin
							state <= shared;
							newState <= read_miss;
							mensage <= PlaceReadMissOnBus;
							action <= EmptyAction;
							$display("CPU read miss| Place read miss on bus");
						end
					write_miss:
						begin
							state <= exclusive;
							newState <= write_miss;
							mensage <= PlaceWriteMissOnBus;
							action <= EmptyAction;
							$display("CPU write miss | Place write miss on bus");
						end
					write_hit:
						begin
							state <= exclusive;
							newState <= write_hit;
							mensage <= PlaceInvalidateOnBus;
							action <= EmptyAction;
							$display("CPU write | Place invalidate on bus");
						end
				endcase	
		endcase		
endmodule	