module ID_Stage (
  input clk, rst, hazard, WB_dest, WB_value, WB_wb_en,
  input [31:0] pc_in, instruction,
  output [31:0] pc_out
);

  MUX #(.LENGTH(4)) mux_1 (
    .in_1(instruction[15:12]),
    .in_2(instruction[3:0]),
    .select(mem_write),
    .out(reg_file_src2)
  );
  
  assign pc_out = pc_in;
  
endmodule
