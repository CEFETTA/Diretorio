module PC0(clock, cdb, selectedEmit, enableWB, dataWB);

input clock;
input[21:0]cdb;

reg[3:0]Tag[1:0]; //guarda os dois bancos do processador

//00=I 01=S 10=M
reg[1:0]State[1:0]; //guarda os estados dos dois bancos do processador
reg[1:0]newState[1:0]; //guarda os possiveis proximos estados dos dois bancos do processador
reg[15:0]Data[1:0]; //armazena o dado, quando valido, do banco no processador para cada banco
reg[21:0]selectCDB;
reg [1:0]concludeWB;

reg[15:0]nextData;
reg[2:0]nextTag;

wire[21:0]emit[1:0];
wire[1:0]dataWB;
wire[1:0]abortMem;

reg listen;

output reg[21:0]selectedEmit;
output reg enableWB;
output reg[21:0]dataWB; //[21:19]Tag [15:0]Data

reg[21:0]cpuNextData; //[21:16]Situation [15:0]Data

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
    concludeWB[0] = 0;

    if(cdb != 21'b1111111111111111111111)
    begin
        if(listen == 1)
        begin //processador ouvindo
            if(Tag[0] == cdb[15:13])
            begin
                State[0]=newState[0];
                if(dataWB == 1)
                begin
                    enableWB = 1;
                    dataWB = {Tag[0], 3'b000, Data[0]};
                    concludeWB = 2'b01;
                end
            end
            else
            begin
                if(Tag[1] == cdb[15:13])
                begin
                    State[1]=newState[0];
                    if(dataWB == 1)
                    begin
                        enableWB = 1;
                        dataWB = {Tag[1], 3'b000, Data[1]};
                        concludeWB = 2'b11;
                    end
                end
            end
            listen = 0;
        end
        else
        begin //processador escrevendo
            
            listen = 1;
        end
    end

    if(concludeWB[0] == 1)
    begin
        data[concludeWB[1]] = nextData;
        Tag[concludeWB[1]] = nextTag;
    end

end

endmodule

module PC1(clock, cdb, selectedEmit, enableWB, dataWB);

input clock;
input[21:0]cdb;

reg[3:0]Tag[1:0]; //guarda os dois bancos do processador

//00=I 01=S 10=M
reg[1:0]State[1:0]; //guarda os estados dos dois bancos do processador
reg[1:0]newState[1:0]; //guarda os possiveis proximos estados dos dois bancos do processador
reg[15:0]Data[1:0]; //armazena o dado, quando valido, do banco no processador para cada banco
reg[21:0]selectCDB;
reg [1:0]concludeWB;

reg[15:0]nextData;
reg[2:0]nextTag;

wire[21:0]emit[1:0];
wire[1:0]dataWB;
wire[1:0]abortMem;

reg listen;

output reg[21:0]selectedEmit;
output reg enableWB;
output reg[21:0]dataWB; //[21:19]Tag [15:0]Data

reg[21:0]cpuNextData; //[21:16]Situation [15:0]Data

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
    concludeWB[0] = 0;

    if(cdb != 21'b1111111111111111111111)
    begin
        if(listen == 1)
        begin //processador ouvindo
            if(Tag[0] == cdb[15:13])
            begin
                State[0]=newState[0];
                if(dataWB == 1)
                begin
                    enableWB = 1;
                    dataWB = {Tag[0], 3'b000, Data[0]};
                    concludeWB = 2'b01;
                end
            end
            else
            begin
                if(Tag[1] == cdb[15:13])
                begin
                    State[1]=newState[0];
                    if(dataWB == 1)
                    begin
                        enableWB = 1;
                        dataWB = {Tag[1], 3'b000, Data[1]};
                        concludeWB = 2'b11;
                    end
                end
            end
            listen = 0;
        end
        else
        begin //processador escrevendo
            
            listen = 1;
        end
    end

    if(concludeWB[0] == 1)
    begin
        data[concludeWB[1]] = nextData;
        Tag[concludeWB[1]] = nextTag;
    end
    
end

endmodule