module Val2_Generator(
  input [31:0] rm,
  input [11:0] shift_operand,
  input imm, is_ld_st,
  output reg [31:0] val2
  );
  
  integer i;
  
  always @(*) begin
    if(is_ld_st) begin
      val2 = {20'b0, shift_operand};
    end
    
    else if(imm) begin
      val2 = {24'b0, shift_operand[7:0]};
      for(i = 0; i < {shift_operand[11:8],1'b0}; i = i + 1) begin
        val2 = {val2[0],val2[31:1]};
      end
    end
    else begin
      if(shift_operand[6:5] == 2'b00)
        val2 = rm << shift_operand[11:7];
      else if(shift_operand[6:5] == 2'b01)
        val2 = rm >> shift_operand[11:7];
      else if(shift_operand[6:5] == 2'b10)
        val2 = rm >>> shift_operand[11:7];
      else if(shift_operand[6:5] == 2'b11) begin
        val2 = rm;
        for(i = 0; i < shift_operand[11:7]; i = i + 1) begin
          val2 = {val2[0], val2[31:1]};
        end
      end
      else
        val2 = rm << shift_operand[11:7];
    end
  end
  
endmodule
        
