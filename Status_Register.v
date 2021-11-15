//`include "Constants.v"
module Status_Register (
    input clk, rst,
    input s,// s is load signal
    input [3:0] i_status_bits,

    output reg [3:0] o_status_bits
);


	always@(negedge clk, posedge rst) 
	begin
		if (rst) o_status_bits <= 0;
		else if (s) o_status_bits <= i_status_bits;
	end
	
endmodule
