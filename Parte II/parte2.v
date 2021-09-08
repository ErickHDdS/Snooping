module parte2(clock, Instruc);

  input clock;
  input [9:0] Instruc;

  // Cada instrução é dividida da seguinte maneira:
  // Op    1 bit    X---------
  // proc  2 bits   -XX-------
  // tag   3 bits   ---XXX----
  // valor 4 bits   ------XXXX
  // TOTAL 10 bits

  localparam [1:0] proc1 = 2'b00, proc2 = 2'b01, proc3 = 2'b10;
  localparam [1:0] ReadMiss = 2'b01, ReadHit = 2'b10, WriteBack = 2'b11;

  wire [1:0] step;
  wire [8:0] OutCache1, OutCache2, OutCache3, OutMemory, OutBus;
  wire [8:0] q1, q2, q3;

  counter cnt (.clock(clock), .q(step));

  cache #(.NAME(proc1), .ReadMiss(ReadMiss), 
  .ReadHit(ReadHit), .WriteBack(WriteBack)) 
  cache1 (.step(step), .instruction(Instruc), .InBus(OutBus), .OutBus(OutCache1),
    .q(q1));

  cache #(.NAME(proc2), .ReadMiss(ReadMiss), 
	 .ReadHit(ReadHit), .WriteBack(WriteBack)) 
	 cache2 (.step(step), .instruction(Instruc), .InBus(OutBus), .OutBus(OutCache2),
    .q(q2));
  
    cache #(.NAME(proc3), .ReadMiss(ReadMiss), 
	 .ReadHit(ReadHit), .WriteBack(WriteBack)) 
	 cache3 (.step(step), .instruction(Instruc), .InBus(OutBus), .OutBus(OutCache3),
    .q(q3));

  memory #(.ReadMiss(ReadMiss),.WriteBack(WriteBack))
  Memo (.bus(OutBus), .q(OutMemory));

  bus #(.ReadHit(ReadHit)) 
  Bus_data (.proc1(OutCache1), .proc2(OutCache2), .proc3(OutCache3), .Memory(OutMemory),
 .q(OutBus));

endmodule