module Data_Memory(
  input             clk, 
  input             rst, 
  input             MEM_w_en, 
  input             MEM_r_en, 
  input      [31:0] address,
  input      [31:0] data_in,

  output reg [31:0] data_out
);

  `define MEMORY_START_POSITION 32'd1024

  reg [31:0] memory [0:63];

  always @(*) begin
    if (MEM_r_en)
      data_out <= memory[(address - `MEMORY_START_POSITION) >> 2];
    else
      data_out <= 0;
  end
    
  always @(posedge clk) begin
    if (MEM_w_en) begin
      memory[(address - `MEMORY_START_POSITION) >> 2] <= data_in;
    end
  end

endmodule