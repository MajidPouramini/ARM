`include "Constants.v"

module ConditionCheck (
  input [3:0] cond,
  input [3:0] status,
  output reg result
);

  wire z, c, n, v;
  assign {z, c, n, v} = status;

  always @(*) begin
    result = 1'b0;
    case(cond)
      `EQ: begin
        result = z;
      end
      `NE: begin
        result = ~z;
      end
      `CS_HS: begin
        result = c;
      end
      `CC_LO: begin
        result = ~c;
      end
      `MI: begin
        result = n;
      end
      `PL: begin
        result = ~n;
      end
      `VS: begin
        result = v;
      end
      `VC: begin
        result = ~v;
      end
      `HI: begin
        result = c & ~z;
      end
      `LS: begin
        result = ~c & z;
      end
      `GE: begin
        result = (n & v) | (~n & ~v);
      end
      `LT: begin
        result = (n & ~v) | (~n & v);
      end
      `GT: begin
        result = ~z & ((n & v) | (~n & ~v));
      end
      `LE: begin
        result = z | ((n & ~v) | (~n & v));
      end
      `AL: begin
        result = 1'b1;
      end
    endcase
  end
endmodule
