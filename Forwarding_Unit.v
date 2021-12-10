module Forwarding_Unit (
  input enable,
  input [3:0] src_1, src_2,
  input [3:0] WB_dest, MEM_dest,
  input WB_wb_en, MEM_wb_en,
  output reg [1:0] sel_src_1, sel_src_2
);

  `define SELECT_ID_VALUE  2'b00
  `define SELECT_MEM_VALUE 2'b01
  `define SELECT_WB_VALUE  2'b10

  always @(*) begin
    sel_src_1 = `SELECT_ID_VALUE;
    sel_src_2 = `SELECT_ID_VALUE;

    if (enable) begin
      if (MEM_wb_en == 1'b1) begin
        if (MEM_dest == src_1) begin
          sel_src_1 = `SELECT_MEM_VALUE;
        end
        if (MEM_dest == src_2) begin
          sel_src_2 = `SELECT_MEM_VALUE; 
        end
      end
      if (WB_wb_en == 1'b1) begin
        if (WB_dest == src_1) begin
          sel_src_1 = `SELECT_WB_VALUE;
        end
        if (WB_dest == src_2) begin
          sel_src_2 = `SELECT_WB_VALUE; 
        end 
      end
    end
  end

endmodule
