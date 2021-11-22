module MEM_Stage (
    input clk, rst, WB_en_in, mem_r_en_in, MEM_w_en, 
    input [3:0] dest_in,
    input [31:0] alu_res_in, val_rm,

    output wb_en_out, MEM_r_en_out, 
    output [3:0] dest_out,
    output [31:0] data_mem_out, alu_res_out
);
  
  assign alu_res_out = alu_res_in;
  assign wb_en_out = wb_en_in;
  assign mem_r_en_out = mem_r_en_in;
  assign MEM_w_en_out = MEM_w_en;
  assign dest_out = dest_in;

  Data_Memory data_memory (
    .clk(clk),
    .rst(rst),
    .MEM_w_en(MEM_w_en),
    .MEM_r_en(MEM_r_en_in),
    .address(alu_res_in),
    .data_in(val_rm),
    .data_out(data_mem_out)
  );
  
endmodule