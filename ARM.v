module ARM (
  input clk, rst
  );
  
  wire [31:0] IF_pc_out, IF_instruction_out;
  wire [31:0] ID_pc_in, ID_pc_out, ID_instruction_in;
  wire [31:0] EXE_pc_in, EXE_pc_out;
  wire [31:0] MEM_pc_in, MEM_pc_out;
  wire [31:0] WB_pc_in, WB_pc_out;
  
  IF_Stage if_stage (clk, rst, 1'b0, 1'b0, 32'b0, IF_pc_out, IF_instruction_out);
  IF_Stage_Reg if_stage_reg (clk, rst, 1'b0, 1'b0, IF_pc_out, IF_instruction_out, ID_pc_in, ID_instruction_in);
  
  ID_Stage id_stage (clk, rst, ID_pc_in, ID_pc_out);
  ID_Stage_Reg id_stage_reg (clk, rst, ID_pc_out, EXE_pc_in);
  
  EXE_Stage exe_stage (clk, rst, EXE_pc_in, EXE_pc_out);
  EXE_Stage_Reg exe_stage_reg (clk, rst, EXE_pc_out, MEM_pc_in);
  
  MEM_Stage mem_stage (clk, rst, MEM_pc_in, MEM_pc_out);
  MEM_Stage_Reg mem_stage_reg (clk, rst, MEM_pc_out, WB_pc_in);
  
  WB_Stage wb_stage (clk, rst, WB_pc_in, WB_pc_out);
  
endmodule
    
  
