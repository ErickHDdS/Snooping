module bus #(parameter ReadHit)(processador1, processador2, processador3, memory, q);
  
  input [8:0] processador1, processador2, processador3, memory;
  output reg [8:0] q;
      
  wire [8:0] Default = {ReadHit, 3'b0, 4'b0};

  always@(*)
    if(processador1 != Default)
      q <= processador1;
		
    else if(processador2 != Default)
      q <= processador2;
	
	else if(processador3 != Default)
      q <= processador3;	
		
    else
      q <= memory;

endmodule
