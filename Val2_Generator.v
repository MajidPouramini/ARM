`include "Constants.v"

module Val2_Generator(
  input [31:0] rm,
  input [11:0] shift_operand,
  input imm, MEM_write_or_read_en,
  
  output reg [31:0] val_2
);
  
  integer i;
  
  always @(*) begin
    if (MEM_write_or_read_en) begin
      val_2 = { 20'b0, shift_operand };
    end
    
    else if (imm) begin
      val_2 = { 24'b0, shift_operand[7:0] };
      for (i = 0; i < { shift_operand[11:8], 1'b0 }; i = i + 1) begin
        val_2 = { val_2[0], val_2[31:1] };
      end
    end

    else begin
      if (shift_operand[6:5] == `LSL)
        val_2 = rm << shift_operand[11:7];

      else if (shift_operand[6:5] == `LSR)
        val_2 = rm >> shift_operand[11:7];

      else if (shift_operand[6:5] == `ASR)
        val_2 = rm >>> shift_operand[11:7];

      else if (shift_operand[6:5] == `ROR) begin
        val_2 = rm;
        for (i = 0; i < shift_operand[11:7]; i = i + 1) begin
          val_2 = { val_2[0], val_2[31:1] };
        end
      end

      else
        val_2 = rm << shift_operand[11:7];
    end
  end
  
endmodule
        
