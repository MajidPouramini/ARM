module IF_Stage (
  input         clk,
  input         rst,
  input         freeze,
  input         branch_taken,
  input  [31:0] branch_addr,

  output [31:0] pc,
  output [31:0] instruction
);
  
  wire[31:0] mux_in, mux_out, pc_increment, pc_in, pc_out;
  
  MUX #(.LENGTH(32)) mux (
    .in_1(mux_in),
    .in_2(branch_addr),
    .select(branch_taken),

    .out(mux_out)
  );
  
  PC pc_module(
    .clk(clk),
    .rst(rst),
    .freeze(freeze),
    .pc_in(pc_in),

    .pc_out(pc_out)
  );
  
  Instruction_Memory instruction_memory(
    .clk(clk),
    .rst(rst),
    .address(pc_out),

    .instruction(instruction)
  );
  
  assign pc_in = mux_out;
  assign pc_increment = pc_out + 4;
  assign mux_in = pc_increment;
  assign pc = pc_increment;
  
endmodule
