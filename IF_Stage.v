module IF_Stage (
  input clk, rst, freeze, branch_taken,
  input [31:0] branchAddr,
  output [31:0] PC, Instruction
  );
  
  wire[31:0] mux_in, mux_out, pc_increment, pc_in, pc_out;
  
  MUX mux (branchAddr, mux_in, branch_taken, mux_out);
  
  PC pc(clk, rst, 1'b0, pc_in, pc_out);
  
  Instruction_Memory instruction_memory(clk, rst, pc_out, Instruction);
  
  assign pc_in = mux_out;
  assign pc_increment = pc_out + 4;
  assign mux_in = pc_increment;
  assign PC = pc_increment;
  
endmodule
