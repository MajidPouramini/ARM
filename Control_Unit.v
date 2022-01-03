`include "Constants.v"

module Control_Unit(
  input            s_in,
  input      [1:0] mode,
  input      [3:0] op_code,

  output reg       MEM_r_en,
  output reg       MEM_w_en,
  output reg       WB_en,
  output reg       s_out,
  output reg       b,
  output reg [3:0] exec_cmd
);

  always @(op_code, mode, s_in) begin
    exec_cmd = `NOP_ALU_CMD;
    MEM_r_en = 1'b0;
    MEM_w_en = 1'b0;
    WB_en = 1'b0;
    b = 1'b0;
    s_out = s_in;
    
    case (mode)
      `ARITHMATIC: begin
        case (op_code)
          `MOV_OP_CODE: begin
            WB_en = 1'b1;
            exec_cmd = `MOV_ALU_CMD;
          end
          `MVN_OP_CODE: begin
            WB_en = 1'b1;
            exec_cmd = `MVN_ALU_CMD;
          end
          `ADD_OP_CODE: begin
            WB_en = 1'b1;
            exec_cmd = `ADD_ALU_CMD;
          end
          `ADC_OP_CODE: begin
            WB_en = 1'b1;
            exec_cmd = `ADC_ALU_CMD;
          end
          `SUB_OP_CODE: begin
            WB_en = 1'b1;
            exec_cmd = `SUB_ALU_CMD;
          end
          `SBC_OP_CODE: begin
            WB_en = 1'b1;
            exec_cmd = `SBC_ALU_CMD;
          end
          `AND_OP_CODE: begin
            WB_en = 1'b1;
            exec_cmd = `AND_ALU_CMD;
          end
          `ORR_OP_CODE: begin
            WB_en = 1'b1;
            exec_cmd = `ORR_ALU_CMD;
          end
          `EOR_OP_CODE: begin
            WB_en = 1'b1;
            exec_cmd = `EOR_ALU_CMD;
          end
          `CMP_OP_CODE: begin
            exec_cmd = `SUB_ALU_CMD;
          end
          `TST_OP_CODE: begin
            exec_cmd = `AND_ALU_CMD;
          end 
        endcase
      end
      `MEMORY: begin
        case (s_in)
          1'b1: begin
            MEM_r_en = 1'b1;
            exec_cmd = `ADD_ALU_CMD;
            WB_en = 1'b1;
          end
          1'b0: begin
            MEM_w_en = 1'b1;
            exec_cmd = `ADD_ALU_CMD;
          end
        endcase
      end
      `BRANCH: begin
        b = 1'b1;
      end
    endcase
  end

endmodule

