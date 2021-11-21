`include "Constants.v"

module ALU(
  input [31:0] val_1, val_2,
  input [3:0] exec_cmd,
  input cin,
  
  output reg [31:0] alu_res,
  output [3:0] status_bits
);
  
  reg v, cout;
  wire z, n;
  
  assign n = alu_res[31];
  assign z = (alu_res == 32'b0) ? 1'b1 : 1'b0;
  assign status_bits = {z, cout, n, v};
  
  always @(*) begin
    cout = 1'b0;
    v = 1'b0;
    
    case(exec_cmd)
      
      `MOV_ALU_CMD: begin
        alu_res = val_2;
      end
      
      `MVN_ALU_CMD: begin
        alu_res = ~val_2;
      end
      
      `ADD_ALU_CMD: begin
        {cout, alu_res} = val_1 + val_2;
        v = ((val_1[31] == val_2[31]) & (alu_res[31] == ~val_1[31]));
      end
      
      `ADC_ALU_CMD: begin
        {cout, alu_res} = val_1 + val_2 + cin;
        v = ((val_1[31] == val_2[31]) & (alu_res[31] == ~val_1[31]));
      end
      
      `SUB_ALU_CMD: begin
        {cout, alu_res} = {val_1[31], val_1} - {val_2[31], val_2};
        v = ((val_1[31] == ~val_2[31]) & (alu_res[31] == ~val_1[31]));
      end
      
      `SBC_ALU_CMD: begin
        {cout, alu_res} = {val_1[31], val_1} - {val_2[31], val_2} - cin;
        v = ((val_1[31] == ~val_2[31]) & (alu_res[31] == ~val_1[31]));
      end
      
      `AND_ALU_CMD: begin
        alu_res = val_1 & val_2;
      end
      
      `ORR_ALU_CMD: begin
        alu_res = val_1 | val_2;
      end
      
      `EOR_ALU_CMD: begin
        alu_res = val_1 ^ val_2;
      end
    endcase
  end
endmodule