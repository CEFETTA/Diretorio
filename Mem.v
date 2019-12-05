module Mem(clock, dataWB_enable, dataWB_data);

input clock, dataWB_enable;
input[16:0] dataWB_data;
reg[16:0]data[7:0];

initial begin
	data[0] = 16'b0000000000001010; //0010
	data[1] = 16'b0000000000001000; //0008
	data[2] = 16'b0000000000001010; //0010
	data[3] = 16'b0000000000010010; //0018
	data[4] = 16'b0000000000010100; //0020
	data[5] = 16'b0000000000011100; //0028
	data[6] = 16'b0000000001000100; //0068
	data[7] = 16'b0000000001100000; //0096
end

endmodule
