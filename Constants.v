// Instruction Modes
`define ARITHMATIC      2'b00
`define MEMORY          2'b01
`define BRANCH          2'b10
`define CO_PROCESSOR    2'b11       // Not implemented

// Instruction OP-Codes
`define MOV_OP_CODE     4'b1101
`define MVN_OP_CODE     4'b1111
`define ADD_OP_CODE     4'b0100
`define ADC_OP_CODE     4'b0101
`define SUB_OP_CODE     4'b0010
`define SBC_OP_CODE     4'b0110
`define AND_OP_CODE     4'b0000
`define ORR_OP_CODE     4'b1100
`define EOR_OP_CODE     4'b0001
`define CMP_OP_CODE     4'b1010
`define TST_OP_CODE     4'b1000
`define LDR_OP_CODE     4'b0100
`define STR_OP_CODE     4'b0100

// Instruction Conditions
`define EQ              4'b0000
`define NE              4'b0001
`define CS_HS           4'b0010
`define CC_LO           4'b0011
`define MI              4'b0100
`define PL              4'b0101
`define VS              4'b0110
`define VC              4'b0111
`define HI              4'b1000
`define LS              4'b1001
`define GE              4'b1010
`define LT              4'b1011
`define GT              4'b1100
`define LE              4'b1101
`define AL              4'b1110
`define _               4'b1111

// ALU Commands
`define NOP_ALU_CMD     4'b0000     // No opration
`define MOV_ALU_CMD     4'b0001
`define ADD_ALU_CMD     4'b0010
`define ADC_ALU_CMD     4'b0011
`define SUB_ALU_CMD     4'b0100
`define SBC_ALU_CMD     4'b0101
`define AND_ALU_CMD     4'b0110
`define ORR_ALU_CMD     4'b0111
`define EOR_ALU_CMD     4'b1000
`define MVN_ALU_CMD     4'b1001

