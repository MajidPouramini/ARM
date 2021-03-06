module Status_Register (
  input            clk,
  input            rst,
  input            s,
  input      [3:0] status_bits_in,
  
  output reg [3:0] status_bits_out
);

	always @(negedge clk, posedge rst) 
	begin
		if (rst) begin
		  status_bits_out <= 4'b0;
		end
		else if (s) begin
      status_bits_out <= status_bits_in;
    end
    else begin
      status_bits_out <= status_bits_out;
    end
	end
	
endmodule
