module IF_Stage_Reg (
  input clk, rst, freez, flush,
  input [31:0] PC_in, Instruction_in,
  output reg [31:0] PC, Instruction
  );
  
  always@(posedge clk, posedge rst) begin
    if (rst) begin
      PC <= 32'b0;
      Instruction <= 32'b0;
    end
    else if (flush) begin
      PC <= 32'b0;
      Instruction <= 32'b0;
    end
    else if (clk) begin
      PC <= PC_in;
      Instruction <= Instruction_in;
    end
    else begin
      PC <= PC;
      Instruction <= Instruction;
    end
  end
    
endmodule 
