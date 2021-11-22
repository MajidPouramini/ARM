module EXE_Stage (
  input clk, rst, MEM_r_en_in, MEM_w_en_in, WB_en_in, imm, s_in, status
  input [3:0] exec_cmd, dest_in,
  input [11:0] shift_operand,
  input [23:0] signed_immed_24,
  input [31:0] val_rm_in, val_rn, pc_in

  output WB_en_out, MEM_r_en_out, MEM_w_en_out, branch_taken, s_out,
  output [31:0] branch_address, alu_res,
  output [3:0] status_bits,
  output [31:0] val_rm_out,
  output [3:0] dest_out
);

  assign MEM_r_en_out = MEM_r_en_in;
  assign MEM_w_en_out = MEM_w_en_in;
  assign WB_en_out = WB_en_in;
  assign dest_out = dest_in;

  wire MEM_write_or_read_en;
  assign MEM_write_or_read_en = MEM_r_en_in | MEM_w_en_in;

  wire [31:0] val_2;

  Val2_Generator val2_generator(
    .rm(val_rm_out),
    .shift_operand(shift_operand),
    .imm(imm),
    .MEM_write_or_read_en(MEM_write_or_read_en),

    .val_2(val_2)
  );

  ALU alu(
    .val_1(val_rn), 
    .val_2(val_2),
    .exec_cmd(exec_cmd),
    .cin(status),

    .alu_res(alu_res),
    .status_bits(status_bits)
  );

  assign branch_address = pc_in + {{6{signed_immed_24[23]}}, signed_immed_24, 2'b0};

endmodule