module ID_Stage_Reg (
  input clk, rst,
  input [31:0] PC_in,
  output reg [31:0] PC
  );

  always@(posedge clk, posedge rst) begin
    if (rst)
      PC <= 32'b0;
    else if (clk)
      PC <= PC_in;
    else
      PC <= PC;
  end
    
endmodule 
