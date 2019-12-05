module L2(clock);

input clock;
reg[16:0]Data[3:0];
reg[2:0]Tag[3:0];
reg[1:0]Sharers[3:0];
reg[1:0]State[3:0];

initial begin

Data[0] = 16'b0000000000001010; //0010
Data[1] = 16'b0000000000001000; //0008
Data[2] = 16'b0000000001000100; //0068
Data[3] = 16'b0000000000010010; //0018

Tag[0] = 3'b000; //100 = Mem[0]
Tag[1] = 3'b001; //108 = Mem[1]
Tag[2] = 3'b110; //130 = Mem[6]
Tag[3] = 3'b011; //118 = Mem[3]

 //00=DI 01=DS 10=DM
State[0] = 2'b10; //DM
State[0] = 2'b01; //DS
State[0] = 2'b10; //DM
State[0] = 2'b01; //DS


//[ P0?, P1? ]
Sharers[0] = 2'b10;
Sharers[1] = 2'b10;
Sharers[2] = 2'b01;
Sharers[3] = 2'b01;

end

endmodule