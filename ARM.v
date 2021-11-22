module ARM (
  input clk, rst
);
  
  // global wires
  wire branch_taken, s, WB_en, hazard;
  wire [3:0] status_bits, WB_dest, src_1, src_2;
  wire [31:0] branch_address, WB_value;

  // wires between IF and IF_REG
  wire [31:0] IF_pc_out, IF_instruction_out;

  IF_Stage if_stage (
    .clk(clk),
    .rst(rst),
    .freeze(hazard),
    .branch_taken(branch_taken),
    .branch_addr(branch_address),

    .pc(IF_pc_out),
    .instruction(IF_instruction_out)
  );

  // wires between IF_REG and ID 
  wire [31:0] ID_pc_in, ID_instruction_in;

  IF_Stage_Reg if_stage_reg (
    .clk(clk),
    .rst(rst),
    .freeze(hazard),
    .flush(branch_taken),
    .pc_in(IF_pc_out),
    .instruction_in(IF_instruction_out),
    
    .pc_out(ID_pc_in),
    .instruction_out(ID_instruction_in)
  );

  // wires between ID and ID_REG
  wire ID_two_src, ID_imm, ID_MEM_r_en, ID_MEM_w_en, ID_WB_enable, ID_s, ID_b;
  wire [3:0] ID_dest, ID_exec_cmd;
  wire [11:0] ID_shift_operand;
  wire [23:0] ID_signed_immed_24;
  wire [31:0] ID_pc_out, ID_val_rm, ID_val_rn;
  
  ID_Stage id_stage (
    .clk(clk),
    .rst(rst),
    .hazard(hazard),
    .WB_value(WB_value),
    .WB_wb_en(WB_en),
    .status(status_bits),
    .WB_dest(WB_dest),
    .pc_in(ID_pc_in),
    .instruction(ID_instruction_in),

    .two_src(ID_two_src),
    .imm_out(ID_imm),
    .MEM_r_en_out(ID_MEM_r_en),
    .MEM_w_en_out(ID_MEM_w_en),
    .WB_enable_out(ID_WB_enable),
    .s_out(ID_s),
    .b_out(ID_b),
    .dest(ID_dest),
    .exec_cmd_out(ID_exec_cmd),
    .src_1(src_1),
    .src_2(src_2),
    .shift_operand(ID_shift_operand),
    .signed_immed_24(ID_signed_immed_24),
    .pc_out(ID_pc_out),
    .val_rm(ID_val_rm),
    .val_rn(ID_val_rn)
  );

  // wires between ID_REG and EXE
  wire EXE_MEM_r_en_in, EXE_MEM_w_en_in, EXE_WB_enable_in, EXE_imm;
  wire [3:0] EXE_status, EXE_cmd, EXE_dest_in;
  wire [11:0] EXE_shift_operand;
  wire [23:0] EXE_signed_immed_24;
  wire [31:0] EXE_pc_in, EXE_val_rm_in, EXE_val_rn;

  ID_Stage_Reg id_stage_reg (
    .clk(clk),
    .rst(rst),
    .flush(branch_taken),
    .status_in(status_bits),
    .imm_in(ID_imm),
    .MEM_r_en_in(ID_MEM_r_en), 
    .MEM_w_en_in(ID_MEM_w_en), 
    .WB_enable_in(ID_WB_enable), 
    .s_in(ID_s), 
    .b_in(ID_b),
    .exec_cmd_in(ID_exec_cmd), 
    .dest_in(ID_dest),
    .shift_operand_in(ID_shift_operand),
    .signed_immed_24_in(ID_signed_immed_24),
    .pc_in(ID_pc_out),
    .val_rm_in(ID_val_rm), 
    .val_rn_in(ID_val_rn),

    .status_out(EXE_status), 
    .imm_out(EXE_imm), 
    .MEM_r_en_out(EXE_MEM_r_en_in), 
    .MEM_w_en_out(EXE_MEM_w_en_in), 
    .WB_enable_out(EXE_WB_enable_in), 
    .s_out(s), 
    .b_out(branch_taken),
    .exec_cmd_out(EXE_cmd),
    .dest_out(EXE_dest_in),
    .shift_operand_out(EXE_shift_operand),
    .signed_immed_24_out(EXE_signed_immed_24),
    .pc_out(EXE_pc_in),
    .val_rm_out(EXE_val_rm_in), 
    .val_rn_out(EXE_val_rn)
  );

  // wires between EXE and EXE_REG
  wire EXE_WB_en_out, EXE_MEM_r_en_out, EXE_MEM_w_en_out;
  wire [3:0] EXE_status_bits, EXE_dest_out;
  wire [31:0] EXE_alu_res, EXE_val_rm_out;
  
  EXE_Stage exe_stage (
    .clk(clk), 
    .rst(rst), 
    .MEM_r_en_in(EXE_MEM_r_en_in), 
    .MEM_w_en_in(EXE_MEM_w_en_in), 
    .WB_en_in(EXE_WB_enable_in), 
    .imm(EXE_imm), 
    .status(EXE_status),
    .exec_cmd(EXE_cmd), 
    .dest_in(EXE_dest_in),
    .shift_operand(EXE_shift_operand),
    .signed_immed_24(EXE_signed_immed_24),
    .val_rm_in(EXE_val_rm_in), 
    .val_rn(EXE_val_rn), 
    .pc_in(EXE_pc_in),

    .WB_en_out(EXE_WB_en_out), 
    .MEM_r_en_out(EXE_MEM_r_en_out), 
    .MEM_w_en_out(EXE_MEM_w_en_out), 
    .branch_taken(branch_taken), 
    .branch_address(branch_address), 
    .alu_res(EXE_alu_res),
    .status_bits(EXE_status_bits),
    .val_rm_out(EXE_val_rm_out),
    .dest_out(EXE_dest_out)
  );

  Status_Register status_register (
    .clk(clk), 
    .rst(rst),
    .s(s),
    .status_bits_in(EXE_status_bits),

    .status_bits_out(status_bits)
  );

  // wires between EXE_REG and MEM
  wire MEM_r_en_in, MEM_w_en, MEM_WB_en_in;
  wire [3:0] MEM_dest_in;
  wire [31:0] MEM_alu_res_in, MEM_val_rm;

  EXE_Stage_Reg exe_stage_reg (
    .clk(clk), 
    .rst(rst), 
    .WB_en_in(EXE_WB_en_out), 
    .MEM_r_en_in(EXE_MEM_r_en_in),
    .MEM_w_en_in(EXE_MEM_r_en_out),
    .dest_in(EXE_dest_out),
    .alu_res_in(EXE_alu_res),
    .val_rm_in(EXE_val_rm_out),

    .WB_en_out(MEM_WB_en_in), 
    .MEM_r_en_out(MEM_r_en_in), 
    .MEM_w_en_out(MEM_w_en),
    .dest_out(MEM_dest_in),
    .alu_res_out(MEM_alu_res_in), 
    .val_rm_out(MEM_val_rm)
  );

  // wires between MEM and MEM_REG
  wire MEM_WB_en_out, MEM_r_en_out;
  wire [3:0] MEM_dest_out;
  wire [31:0] MEM_alu_res_out, data_mem_out;

  MEM_Stage mem_stage (
    .clk(clk), 
    .rst(rst), 
    .WB_en_in(MEM_WB_en_in), 
    .MEM_r_en_in(MEM_r_en_in), 
    .MEM_w_en(MEM_w_en), 
    .dest_in(MEM_dest_in),
    .alu_res_in(MEM_alu_res_in), 
    .val_rm(MEM_val_rm),

    .WB_en_out(MEM_WB_en_out), 
    .MEM_r_en_out(MEM_r_en_out), 
    .dest_out(MEM_dest_out),
    .data_mem_out(data_mem_out), 
    .alu_res_out(MEM_alu_res_out)
  );

  // wires between MEM_REG and WB
  wire WB_MEM_r_en;
  wire [31:0] WB_alu_res, WB_data_mem;
  
  MEM_Stage_Reg mem_stage_reg (
    .clk(clk), 
    .rst(rst), 
    .WB_en_in(MEM_WB_en_out), 
    .MEM_r_en_in(MEM_r_en_out), 
    .dest_in(MEM_dest_out),
    .alu_res_in(MEM_alu_res_out), 
    .data_mem_in(data_mem_out),

    .WB_en_out(WB_en), 
    .MEM_r_en_out(WB_MEM_r_en), 
    .alu_res_out(WB_alu_res),
    .dest_out(WB_dest),
    .data_mem_out(WB_data_mem)
  );

  WB_Stage wb_stage (
    .clk(clk),
    .rst(rst),
    .MEM_r_en(WB_MEM_r_en),
    .alu_res(WB_alu_res),
    .data_mem(WB_data_mem),

    .WB_value(WB_value)
  );

  Hazard_Detection_Unit hazard_detection_unit (
    .EXE_WB_en(EXE_WB_en_out),
    .MEM_WB_en(MEM_WB_en_out),
    .two_src(ID_two_src),
    .src_1(src_1),
    .src_2(src_2),
    .EXE_dest(EXE_dest_out),
    .MEM_dest(MEM_dest_out),
    
    .hazard_detected(hazard)
  );
  
endmodule
    
  
