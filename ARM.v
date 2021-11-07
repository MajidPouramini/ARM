module ARM (
  input clk, rst
);
  
  wire branch_taken;
  wire [31:0] IF_pc_out, IF_instruction_out;
  wire [31:0] ID_pc_in, ID_instruction_in;
  
  // Instruction Fetch
  IF_Stage if_stage (
    .clk(clk),
    .rst(rst),
    .freeze(1'b0), // TODO: require hazard detection unit
    .branch_taken(1'b0), // TODO: require EXE stage
    .branch_addr(32'b0), // TODO: require EXE stage

    .pc(IF_pc_out),
    .instruction(IF_instruction_out)
  );

  IF_Stage_Reg if_stage_reg (
    .clk(clk),
    .rst(rst),
    .freeze(1'b0), // TODO: require hazard detection unit
    .flush(1'b0), // TODO: require EXE stage
    .pc_in(IF_pc_out),
    .instruction_in(IF_instruction_out),
    
    .pc_out(ID_pc_in),
    .instruction_out(ID_instruction_in)
  );

  wire ID_two_src, ID_imm, ID_MEM_r_en, ID_MEM_w_en, ID_WB_enable, ID_s, ID_b;
  wire [3:0] ID_dest, ID_exec_cmd;
  wire [11:0] ID_shift_operand;
  wire [23:0] ID_signed_immed_24;
  wire [31:0] ID_pc_out, ID_val_rm, ID_val_rn;
  
  wire [31:0] EXE_pc_in;
  
  // Instruction Decode
  ID_Stage id_stage (
    .clk(clk),
    .rst(rst),
    .hazard(1'b0), // TODO: require hazard detection unit
    .WB_value(32'b0), // TODO: require WB stage 
    .WB_wb_en(1'b0), // TODO: require WB stage
    .status(4'b0), // TODO: require status register
    .WB_dest(4'b0), // TODO: require WB stage
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
    .shift_operand(ID_shift_operand),
    .signed_immed_24(ID_signed_immed_24),
    .pc_out(ID_pc_out),
    .val_rm(ID_val_rm),
    .val_rn(ID_val_rn)
  );

  // TODO set wire for if stage reg
  ID_Stage_Reg id_stage_reg (
    .clk(clk),
    .rst(rst),
    .flush(1'b0), // TODO: require EXE stage
    .status_in(1'b0), // TODO: require status register
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
    .MEM_r_en_out(EXE_MEM_r_en), 
    .MEM_w_en_out(EXE_MEM_w_en), 
    .WB_enable_out(EXE_WB_enable), 
    .s_out(EXE_s), 
    .b_out(branch_taken),
    .exec_cmd_out(EXE_cmd),
    .dest_out(EXE_dest),
    .shift_operand_out(EXE_shift_operand),
    .signed_immed_24_out(EXE_signed_immed_24),
    .pc_out(EXE_pc_in),
    .val_rm_out(EXE_val_rm), 
    .val_rn_out(EXE_val_rn)
  );

  wire [31:0] EXE_pc_out;
  wire [31:0] MEM_pc_in, MEM_pc_out;
  wire [31:0] WB_pc_in, WB_pc_out;
  
  EXE_Stage exe_stage (clk, rst, EXE_pc_in, EXE_pc_out);
  EXE_Stage_Reg exe_stage_reg (clk, rst, EXE_pc_out, MEM_pc_in);
  
  MEM_Stage mem_stage (clk, rst, MEM_pc_in, MEM_pc_out);
  MEM_Stage_Reg mem_stage_reg (clk, rst, MEM_pc_out, WB_pc_in);
  
  WB_Stage wb_stage (clk, rst, WB_pc_in, WB_pc_out);
  
endmodule
    
  
