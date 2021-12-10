module ID_Stage (
  input clk, rst, hazard, WB_wb_en,
  input [3:0] WB_dest, status,
  input [31:0] pc_in, instruction, WB_value,

  output two_src, imm_out, MEM_r_en_out, MEM_w_en_out, WB_enable_out, s_out, b_out,
  output [3:0] dest, exec_cmd_out, src_1, src_2,
  output [11:0] shift_operand,
  output [23:0] signed_immed_24,
  output [31:0] pc_out, val_rm, val_rn
);

  wire [3:0] mux_1_out;

  assign src_1 = instruction[19:16]; // Rn
  assign src_2 = mux_1_out;

  MUX #(.LENGTH(4)) mux_1 (
    .in_1(instruction[3:0]), // Rm
    .in_2(instruction[15:12]), // Rd
    .select(MEM_w_en_out),

    .out(mux_1_out)
  );

  Register_File register_file (
    .clk(clk),
    .rst(rst),
    .write_back_en(WB_wb_en),
    .src_1(instruction[19:16]), // Rn
    .src_2(mux_1_out),
    .WB_dest(WB_dest),
    .WB_result(WB_value),
    
    .reg_1(val_rn),
    .reg_2(val_rm)
  );

  wire MEM_r_en, MEM_w_en, WB_enable, s, b;
  wire [3:0] exec_cmd;

  Control_Unit control_unit (
		.mode(instruction[27:26]), // Mode
    .op_code(instruction[24:21]), // Op-Code
		.s_in(instruction[20]), // S

		.exec_cmd(exec_cmd),
		.MEM_r_en(MEM_r_en),
    .MEM_w_en(MEM_w_en),
		.WB_en(WB_enable),
    .s_out(s),
		.b(b)
	);

  wire [8:0] control_unit_out;
  assign control_unit_out = {
    exec_cmd,
    MEM_r_en,
    MEM_w_en,
    WB_enable,
    s,
    b
  };

  wire condition_check_out;

  Condition_Check condition_check (
    .cond(instruction[31:28]), // Cond
    .status(status),

    .result(condition_check_out)
  );

  wire [8:0] mux_2_out;

  MUX #(.LENGTH(9)) mux_2 (
    .in_1(control_unit_out),
    .in_2(9'b0),
    .select((~condition_check_out) | hazard),

    .out(mux_2_out)
  );

  assign {
    exec_cmd_out,
    MEM_r_en_out,
    MEM_w_en_out,
    WB_enable_out,
    s_out,
    b_out
  } = mux_2_out;

  assign two_src = ~instruction[25] | MEM_w_en_out;

  assign pc_out = pc_in;

  assign imm_out = instruction[25]; // I
  assign dest = instruction[15:12]; // Rd
  assign shift_operand = instruction[11:0]; // Shifter Operand  
  assign signed_immed_24 = instruction[23:0]; // Signed immed 24
  
endmodule
