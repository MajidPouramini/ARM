module IF_Stage_Reg (
  input clk, rst, freeze, flush,
  input [31:0] pc_in, instruction_in,
  output reg [31:0] pc_out, instruction_out
);
  
  always@(posedge clk, posedge rst) begin
    if (rst) begin
      pc_out <= 32'b0;
      instruction_out <= 32'b0;
    end
    else if (flush) begin
      pc_out <= 32'b0;
      instruction_out <= 32'b0;
    end
    else if (freeze) begin
      pc_out <= pc_out;
      instruction_out <= instruction_out;
    end
    else if (clk) begin
      pc_out <= pc_in;
      instruction_out <= instruction_in;
    end
    else begin
      pc_out <= pc_out;
      instruction_out <= instruction_out;
    end
  end
    
endmodule 
