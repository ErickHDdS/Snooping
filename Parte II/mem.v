module mem(clock, barramentoIn, barramentoOut);
		
		input [10:0] barramentoIn;
		input clock;
		output reg [10:0] barramentoOut;

		// Possiveis operacoes
		localparam read_miss   	= 2'b00;
		localparam write_miss  	= 2'b01;
		localparam invalidate  	= 2'b10;
		localparam empty 			= 2'b11;
		
		reg [3:0] Memoria [1:0];
		/***************************************************/
		initial begin
			Memoria[0] = 4'b1001;
			Memoria[1] = 4'b1000;
		end
		
		always @(posedge clock) begin
			barramentoOut 			= 11'b00000000000;
			if(barramentoIn[5:4] == read_miss) 
			begin
				barramentoOut[10] 	= 0;
				barramentoOut[9:8] 	= barramentoIn[9:8];
				barramentoOut[5:4] 	= empty;
				barramentoOut[3] 		= barramentoIn[3];
				if(barramentoIn[3] == 0) 
				begin
					barramentoOut[2:0] = Memoria[0][2:0];
				end
				else begin 
					barramentoOut[2:0] = Memoria[1][2:0];
				end
			end
		end
endmodule