module WB_Stage(
	input         clk,
	input         rst,
	input         MEM_r_en,
	input  [31:0] alu_res,
	input  [31:0] data_mem,
	
	output [31:0] WB_value
);

  MUX #(.LENGTH(32)) mux (
    .in_1(alu_res),
    .in_2(data_mem),
    .select(MEM_r_en),

    .out(WB_value)
  );

endmodule