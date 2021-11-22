module WB_Stage(
	input clk, rst, MEM_r_en,
	input [31:0] alu_res, data_mem,
	
	output wire [31:0] WB_value
);

  MUX #(.LENGTH(32)) mux (
    .in_1(alu_res),
    .in_2(data_mem),
    .select(MEM_r_en),

    .out(WB_value)
  );

endmodule