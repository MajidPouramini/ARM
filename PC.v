module PC (
  input             clk,
  input             rst,
  input             freeze,
  input      [31:0] pc_in,
  
  output reg [31:0] pc_out
);

  always @(posedge clk, posedge rst) begin
    if (rst) pc_out <= 32'b0;
    else if (freeze) pc_out <= pc_out;
    else if (clk) pc_out <= pc_in;
    else pc_out <= pc_out;
  end

endmodule
