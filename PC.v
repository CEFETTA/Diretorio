module PC0(clock, cdb, selectedEmit);

input clock;

reg[3:0]Tag[1:0]; //guarda os dois bancos do processador

//00=I 01=S 10=M
reg[1:0]State[1:0]; //guarda os estados dos dois bancos do processador
reg[1:0]newState[1:0]; //guarda os possiveis proximos estados dos dois bancos do processador
reg[16:0]Data[1:0]; //armazena o dado, quando valido, do banco no processador para cada banco

wire[21:0]emit[1:0];
wire[1:0]dataWB;
wire[1:0]abortMem;

reg listen;

output reg[21:0]selectedEmit;

initial begin
    State[0] = 2'b10; //M
    State[1] = 2'b01; //S

    Tag[0] = 3'b000; //100 = Mem[0]
    Tag[1] = 3'b001; //108 = Mem[1]

    Data[0] = 16'b0000000000001010; //0010
    Data[1] = 16'b0000000000001000; //0008

    selectedEmit = 21'b1111111111111111111111;

    listen = 1;
end

StateMachine B0(clock, State[0], cdb, listen, newState[0], emit[0], dataWB[0], abortMem[0]);
StateMachine B0(clock, State[1], cdb, listen, newState[1], emit[1], dataWB[1], abortMem[1]);

always@(posedge clock)
begin
    selectedEmit = 21'b1111111111111111111111;

    if(cdb != 21'b1111111111111111111111)
    begin
        if(listen == 1)
        begin
            if(Tag[0] == cdb[15:13])
            begin
                
            end
        end
        else
        begin
            //processador escrevendo
        end
    end

end

endmodule