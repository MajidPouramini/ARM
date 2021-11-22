module MEM_Stage_Reg (
  input clk, rst, WB_en_in, MEM_r_en_in, 
  input [3:0] dest_in,
  input [31:0] alu_res_in, data_mem_in,

  output reg WB_en_out, MEM_r_en_out, 
  output reg [3:0] dest_out,
  output reg [31:0] alu_res_out, data_mem_out
);

  always @(posedge clk, posedge rst) begin
    if (rst) begin
      WB_en_out <= 1'b0;
      MEM_r_en_out <= 1'b0;
      alu_res_out <= 32'b0;
      dest_out <= 4'b0;
      data_mem_out <= 32'b0;
    end
    else if (clk) begin
      WB_en_out <= WB_en_in;
      MEM_r_en_out <= MEM_r_en_in;
      alu_res_out <= alu_res_in;
      dest_out <= dest_in;
      data_mem_out <= data_mem_in;
    end 
    else begin
      WB_en_out <= WB_en_out;
      MEM_r_en_out <= MEM_r_en_out;
      alu_res_out <= alu_res_out;
      dest_out <= dest_out;
      data_mem_out <= data_mem_out;
    end
  end

endmodule