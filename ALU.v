module ALU(
  input [31:0] val1,val2,
  input [3:0] alu_command,
  input cin,
  output reg [31:0]  alu_res,
  output [3:0] status_register
);
  
  reg v, cout;
  wire z,n;
  
  assign n = alu_res[31];
  
  assign z = (alu_res == 32'b0) ? 1 : 0; // ...
  
  assign status_register = {z,cout,n,v};
  
  always @(*) begin
    {cout,v} = 2'b0;
    
    case(alu_command)
      
      4'b0001:begin
        alu_res = val2;
      end
      
      4'b1001: begin
        alu_res = ~val2;
      end
      
      4'b0010:begin
        {cout,alu_res} = val1+val2;
        v = ((val1[31] == val2[31]) & (alu_res[31] != val1[31]));
      end
      
      4'b0011:begin
        {cout, alu_res} = val1 + val2 + cin;
        v = ((val1[31] == val2[31]) & (alu_res[31] != val1[31]));
      end
      
      4'b0100:begin
        {cout, alu_res} = {val1[31], val1} - {val2[31], val2};
        v = ((val1[31] == val2[31]) & (alu_res[31] != val1[31]));
        v = ((val1[31] == ~val2[31]) & (alu_res[31] != val1[31]));
      end
      
      4'b0101:begin
        {cout, alu_res} = {val1[31], val1} - {val2[31], val2} - 33'd1;
        v = ((val1[31] == ~val2[31]) & (alu_res[31] != val1[31]));
      end
      
      4'b0110:begin
        alu_res = val1 & val2;
      end
      
      4'b0111:begin
        alu_res = val1 | val2;
      end
      
      4'b1000:begin
        alu_res = val1 ^ val2;
      end
      
    endcase
  end
endmodule