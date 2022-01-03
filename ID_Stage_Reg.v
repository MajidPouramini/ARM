module ID_Stage_Reg (
  input clk, rst, flush, freeze, imm_in, MEM_r_en_in, MEM_w_en_in, WB_enable_in, s_in, b_in,
  input [3:0] status_in, exec_cmd_in, dest_in, src_1_in, src_2_in,
  input [11:0] shift_operand_in,
  input [23:0] signed_immed_24_in,
  input [31:0] pc_in, val_rm_in, val_rn_in, 
  
  output reg imm_out, MEM_r_en_out, MEM_w_en_out, WB_enable_out, s_out, b_out,
  output reg [3:0] status_out, exec_cmd_out, dest_out, src_1_out, src_2_out,
  output reg [11:0] shift_operand_out,
  output reg [23:0] signed_immed_24_out,
  output reg [31:0] pc_out, val_rm_out, val_rn_out
);

  always @(posedge clk, posedge rst) begin
    if (rst) begin
      status_out <= 4'b0;
      imm_out <= 1'b0;
      MEM_r_en_out <= 1'b0;
      MEM_w_en_out <= 1'b0;
      WB_enable_out <= 1'b0;
      s_out <= 1'b0;
      b_out <= 1'b0;
      exec_cmd_out <= 4'b0;
      dest_out <= 4'b0;
      src_1_out <= 32'b0;
      src_2_out <= 32'b0;
      shift_operand_out <= 12'b0;
      signed_immed_24_out <= 24'b0;
      pc_out <= 32'b0;
      val_rm_out <= 32'b0;
      val_rn_out <= 32'b0;
    end
    else if (flush) begin
      status_out <= 4'b0;
      imm_out <= 1'b0;
      MEM_r_en_out <= 1'b0;
      MEM_w_en_out <= 1'b0;
      WB_enable_out <= 1'b0;
      s_out <= 1'b0;
      b_out <= 1'b0;
      exec_cmd_out <= 4'b0;
      dest_out <= 4'b0;
      src_1_out <= 32'b0;
      src_2_out <= 32'b0;
      shift_operand_out <= 12'b0;
      signed_immed_24_out <= 24'b0;
      pc_out <= 32'b0;
      val_rm_out <= 32'b0;
      val_rn_out <= 32'b0;
    end
    else if (freeze) begin
      status_out <= status_out;
      imm_out <= imm_out;
      MEM_r_en_out <= MEM_r_en_out;
      MEM_w_en_out <= MEM_w_en_out;
      WB_enable_out <= WB_enable_out;
      s_out <= s_out;
      b_out <= b_out;
      exec_cmd_out <= exec_cmd_out;
      dest_out <= dest_out;
      src_1_out <= src_1_out;
      src_2_out <= src_2_out;
      shift_operand_out <= shift_operand_out;
      signed_immed_24_out <= signed_immed_24_out;
      pc_out <= pc_out;
      val_rm_out <= val_rm_out;
      val_rn_out <= val_rn_out;
    end
    else if (clk) begin
      status_out <= status_in;
      imm_out <= imm_in;
      MEM_r_en_out <= MEM_r_en_in;
      MEM_w_en_out <= MEM_w_en_in;
      WB_enable_out <= WB_enable_in;
      s_out <= s_in;
      b_out <= b_in;
      exec_cmd_out <= exec_cmd_in;
      dest_out <= dest_in;
      src_1_out <= src_1_in;
      src_2_out <= src_2_in;
      shift_operand_out <= shift_operand_in;
      signed_immed_24_out <= signed_immed_24_in;
      pc_out <= pc_in;
      val_rm_out <= val_rm_in;
      val_rn_out <= val_rn_in;
    end
    else begin
      status_out <= status_out;
      imm_out <= imm_out;
      MEM_r_en_out <= MEM_r_en_out;
      MEM_w_en_out <= MEM_w_en_out;
      WB_enable_out <= WB_enable_out;
      s_out <= s_out;
      b_out <= b_out;
      exec_cmd_out <= exec_cmd_out;
      dest_out <= dest_out;
      src_1_out <= src_1_out;
      src_2_out <= src_2_out;
      shift_operand_out <= shift_operand_out;
      signed_immed_24_out <= signed_immed_24_out;
      pc_out <= pc_out;
      val_rm_out <= val_rm_out;
      val_rn_out <= val_rn_out;
    end
  end
    
endmodule 
