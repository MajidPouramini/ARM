module Hazard_Detection_Unit(
  input EXE_WB_en, MEM_WB_en, two_src,
  input [3:0] src_1, src_2, EXE_dest, MEM_dest,
	
	output reg hazard_detected
);
	
  always @(*) begin
    if (src_1 == EXE_dest & EXE_WB_en == 1'b1)
      hazard_detected = 1'b1;
    else if (src_1 == MEM_dest & MEM_WB_en == 1'b1)
      hazard_detected = 1'b1;
    else if (src_2 == EXE_dest & EXE_WB_en == 1'b1 & two_src == 1'b1)
      hazard_detected = 1'b1;
    else if (src_2 == MEM_dest & MEM_WB_en == 1'b1 & two_src == 1'b1)
      hazard_detected = 1'b1;
    else
      hazard_detected = 1'b0;
  end
    
endmodule
