module Register_File (
  input clk, rst, write_back_en,
  input [3:0] src_1, src_2, WB_dest,
  input [31:0] WB_result,
  output [31:0] reg_1, reg_2
);

  reg [31:0] registers[0:14];

  assign reg1 = registers[src_1];
  assign reg2 = registers[src_2];

  integer i = 0;

  always @(negedge clk, posedge rst) begin
    if (rst) begin
      for(i = 0; i < 15; i = i + 1)
        registers[i] <= i;
    end
    else if (write_back_en) begin
      registers[WB_dest] = WB_result;
    end
    else begin
      for(i = 0; i < 15; i = i + 1)
        registers[i] <= registers[i];
    end
	end

endmodule
