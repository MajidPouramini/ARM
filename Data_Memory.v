module Data_Memory(
  input clk, rst, MEM_w_en, MEM_r_en, 
  input [31:0] address, data_in,

  output [31:0] data_out
);

  `define MEMORY_START_POSITION 32'd1024

  reg [7:0] memory [0:255];
  wire [31:0] memory_address_0, memory_address_1, memory_address_2, memory_address_3;

  assign memory_address_0 = { address[31:2], 2'b00 } - `MEMORY_START_POSITION;
  assign memory_address_1 = { address[31:2], 2'b01 } - `MEMORY_START_POSITION;
  assign memory_address_2 = { address[31:2], 2'b10 } - `MEMORY_START_POSITION;
  assign memory_address_3 = { address[31:2], 2'b11 } - `MEMORY_START_POSITION;

  assign data_out = 
    MEM_r_en == 1'b1 
      ? { memory[memory_address_0], memory[memory_address_1], memory[memory_address_2], memory[memory_address_3] } 
      : 32'b0;

  always @(posedge clk) begin
    if (MEM_w_en == 1'b1) begin
      memory[memory_address_3] <= data_in[7:0];
      memory[memory_address_2] <= data_in[15:8];
      memory[memory_address_1] <= data_in[23:16];
      memory[memory_address_0] <= data_in[31:24];
    end
  end

endmodule


