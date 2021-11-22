module Instruction_Memory (
  input clk, rst,
  input [31:0] address, 
  output [31:0] instruction
);
  
  reg [31:0] memory[0:1023];
 
  initial begin
    memory[0]  = 32'b1110_00_1_1101_0_0000_0001_101000000001; // MOV    R1, #4096             // R1 = 4096
    memory[1]  = 32'b1110_00_1_1101_0_0000_0000_000000010100; // MOV    R0, #20               // R0 = 20
    memory[2]  = 32'b1110_00_1_1101_0_0000_0010_000100000011; // MOV    R2, #0xC0000000       // R2 = -1073741824
    memory[3]  = 32'b1110_00_0_0100_1_0010_0011_000000000010; // ADDS   R3, R2, R2            // R3 = -2147483648 
    memory[4]  = 32'b1110_00_0_0101_0_0000_0100_000000000000; // ADC    R4, R0, R0            // R4 = 41
    memory[5]  = 32'b1110_00_0_0010_0_0100_0101_000100000100; // SUB    R5, R4, R4 ,LSL #2    // R5 = -123
    memory[6]  = 32'b1110_00_0_0110_0_0000_0110_000010100000; // SBC    R6, R0, R0, LSR #1    // R6 = 10
    memory[7]  = 32'b1110_00_0_1100_0_0101_0111_000101000010; // ORR    R7, R5, R2, ASR #2    // R7 = -123
    memory[8]  = 32'b1110_00_0_0000_0_0111_1000_000000000011; // AND    R8, R7, R3            // R8 = -2147483648
    memory[9]  = 32'b1110_00_0_1111_0_0000_1001_000000000110; // MVN    R9, R6                // R9 = -11
    memory[10] = 32'b1110_00_0_0001_0_0100_1010_000000000101; // EOR    R10, R4, R5           // R10 = -84
    memory[11] = 32'b1110_00_0_1010_1_1000_0000_000000000110; // CMP    R8, R6 
    memory[12] = 32'b0001_00_0_0100_0_0001_0001_000000000001; // ADDNE  R1, R1, R1            // R1 = 8192
    memory[13] = 32'b1110_00_0_1000_1_1001_0000_000000001000; // TST    R9, R8 
    memory[14] = 32'b0000_00_0_0100_0_0010_0010_000000000010; // ADDEQ  R2, R2, R2            // R2 = -1073741824
    memory[15] = 32'b1110_00_1_1101_0_0000_0000_101100000001; // MOV    R0, #1024             // R0 = 1024
    memory[16] = 32'b1110_01_0_0100_0_0000_0001_000000000000; // STR    R1, [R0], #0          // MEM[1024] = 8192
    memory[17] = 32'b1110_01_0_0100_1_0000_1011_000000000000; // LDR    R11, [R0] ,#0         // R11 = 8192
    memory[18] = 32'b1110_01_0_0100_0_0000_0010_000000000100; // STR    R2, [R0], #4          // MEM[1028] = -1073741824
    memory[19] = 32'b1110_01_0_0100_0_0000_0011_000000001000; // STR    R3, [R0], #8          // MEM[1032] = -2147483648
    memory[20] = 32'b1110_01_0_0100_0_0000_0100_000000001101; // STR    R4, [R0], #13         // MEM[1036] = 41
    memory[21] = 32'b1110_01_0_0100_0_0000_0101_000000010000; // STR    R5, [R0], #16         // MEM[1040] = -123
    memory[22] = 32'b1110_01_0_0100_0_0000_0110_000000010100; // STR    R6, [R0], #20         // MEM[1044] = 10
    memory[23] = 32'b1110_01_0_0100_1_0000_1010_000000000100; // LDR    R10, [R0], #4         // R10 = -1073741824
    memory[24] = 32'b1110_01_0_0100_0_0000_0111_000000011000; // STR    R7, [R0], #24         // MEM[1048] = -123
    memory[25] = 32'b1110_00_1_1101_0_0000_0001_000000000100; // MOV    R1, #4                // R1 = 4
    memory[26] = 32'b1110_00_1_1101_0_0000_0010_000000000000; // MOV    R2, #0                // R2 = 0
    memory[27] = 32'b1110_00_1_1101_0_0000_0011_000000000000; // MOV    R3, #0                // R3 = 0
    memory[28] = 32'b1110_00_0_0100_0_0000_0100_000100000011; // ADD    R4, R0, R3, LSL #2 
    memory[29] = 32'b1110_01_0_0100_1_0100_0101_000000000000; // LDR    R5, [R4], #0 
    memory[30] = 32'b1110_01_0_0100_1_0100_0110_000000000100; // LDR    R6, [R4], #4 
    memory[31] = 32'b1110_00_0_1010_1_0101_0000_000000000110; // CMP    R5, R6 
    memory[32] = 32'b1100_01_0_0100_0_0100_0110_000000000000; // STRGT  R6, [R4], #0 
    memory[33] = 32'b1100_01_0_0100_0_0100_0101_000000000100; // STRGT  R5, [R4], #4 
    memory[34] = 32'b1110_00_1_0100_0_0011_0011_000000000001; // ADD    R3, R3, #1 
    memory[35] = 32'b1110_00_1_1010_1_0011_0000_000000000011; // CMP    R3, #3 
    memory[36] = 32'b1011_10_1_0_111111111111111111110111   ; // BLT    #-9 
    memory[37] = 32'b1110_00_1_0100_0_0010_0010_000000000001; // ADD    R2, R2, #1 
    memory[38] = 32'b1110_00_0_1010_1_0010_0000_000000000001; // CMP    R2, R1 
    memory[39] = 32'b1011_10_1_0_111111111111111111110011   ; // BLT    #-13 
    memory[40] = 32'b1110_01_0_0100_1_0000_0001_000000000000; // LDR    R1, [R0], #0          // R1 = -2147483648
    memory[41] = 32'b1110_01_0_0100_1_0000_0010_000000000100; // LDR    R2, [R0], #4          // R2 = -1073741824
    memory[42] = 32'b1110_01_0_0100_1_0000_0011_000000001000; // STR    R3, [R0], #8          // R3 = 41
    memory[43] = 32'b1110_01_0_0100_1_0000_0100_000000001100; // STR    R4, [R0], #12         // R4 = 8192
    memory[44] = 32'b1110_01_0_0100_1_0000_0101_000000010000; // STR    R5, [R0], #16         // R5 = -123
    memory[45] = 32'b1110_01_0_0100_1_0000_0110_000000010100; // STR    R6, [R0], #20         // R4 = 10
    memory[46] = 32'b1110_10_1_0_111111111111111111111111   ; // B      #-1 
  end
  
  assign instruction = memory[address >> 2];
  
endmodule
