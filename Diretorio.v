module Diretorio (clock);

reg[21:0]selectedCDB;
wire[21:0] emitL2, emitPC0, emitPC1;

Mem M0(clock, dataWB_enable, dataWB_data);
L2 l20(clock, selectedCDB, CPUreceiver, emitL2);


endmodule
