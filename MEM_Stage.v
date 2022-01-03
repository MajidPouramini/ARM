module MEM_Stage (
  input clk, rst, WB_en_in, MEM_r_en_in, MEM_w_en,
  input [3:0] dest_in,
  input [31:0] alu_res_in, val_rm,

  output WB_en_out, MEM_r_en_out, SRAM_WE_N, ready,
  output [16:0] SRAM_ADDR, 
  output [3:0] dest_out,
  output [31:0] data_mem_out, alu_res_out,

  inout [31:0] SRAM_DQ
);
  
  wire [3:0] SRAM_controller;

  assign alu_res_out = alu_res_in;
  assign WB_en_out = WB_en_in;
  assign MEM_r_en_out = MEM_r_en_in;
  // assign MEM_w_en_out = MEM_w_en;
  assign dest_out = dest_in;

  // Data_Memory data_memory (
  //   .clk(clk),
  //   .rst(rst),
  //   .MEM_w_en(MEM_w_en),
  //   .MEM_r_en(MEM_r_en_in),
  //   .address(alu_res_in),
  //   .data_in(val_rm),
    
  //   .data_out(data_mem_out)
  // );

  SRAM_Controller sram_controller (
    .clk(clk), 
    .rst(rst), 
    .write_en(MEM_w_en), 
    .read_en(MEM_r_en_in),
    .address(alu_res_in), 
    .write_data(val_rm),

    .ready(ready), 
    .SRAM_UB_N(SRAM_controller[0]), 
    .SRAM_LB_N(SRAM_controller[1]), 
    .SRAM_WE_N(SRAM_WE_N), 
    .SRAM_CE_N(SRAM_controller[2]), 
    .SRAM_OE_N(SRAM_controller[3]),
    .SRAM_ADDR(SRAM_ADDR),
    .read_data(data_mem_out),

    .SRAM_DQ(SRAM_DQ)
);

endmodule