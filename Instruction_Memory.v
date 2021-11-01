module Instruction_Memory (
  input clk, rst,
  input [31:0] address, 
  output [31:0] instruction
  );
  
  reg[31:0] memory[0:6];
 
  initial begin
    memory[0] = 32'b000000_00001_00010_00000_00000000000;
    memory[1] = 32'b000000_00011_00100_00000_00000000000;
    memory[2] = 32'b000000_00101_00110_00000_00000000000;
    memory[3] = 32'b000000_00111_01000_00010_00000000000;
    memory[4] = 32'b000000_01001_01010_00011_00000000000;
    memory[5] = 32'b000000_01011_01100_00000_00000000000;
    memory[6] = 32'b000000_01101_01110_00000_00000000000;
  end
  
  assign instruction = memory[address >> 2];
  
endmodule
