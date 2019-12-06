module PC(clock, emit);

input clock;

reg[3:0]Tag[1:0]; //guarda os dois bancos do processador
reg[1:0]State[1:0]; //guarda os estados dos dois bancos do processador
reg[16:0]Data[1:0]; //armazena o dado, quando valido, do banco nos processadores

output reg[21:0]emit;

endmodule