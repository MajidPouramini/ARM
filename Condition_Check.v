`include "Defines.v"

module ConditionCheck (
    input [`COND_LEN - 1:0] cond,
    input [3:0] status,
    output reg result
    );

    wire z, c, n, v;
    // TODO: order of status registers must be checked.
    assign {z, c, n, v} = status;


    always @(*) begin
        result = 1'b0;
        case(cond)
            `COND_EQ : begin
                result = z;
            end

            `COND_NE : begin
                result = ~z;
            end

            `COND_CS_HS : begin
                result = c;
            end

            `COND_CC_LO : begin
                result = ~c;
            end

            `COND_MI : begin
                result = n;
            end

            `COND_PL : begin
                result = ~n;
            end

            `COND_VS : begin
                result = v;
            end

            `COND_VC : begin
                result = ~v;
            end

            `COND_HI : begin
                result = c & ~z;
            end

            `COND_LS : begin
                result = ~c & z;
            end

            `COND_GE : begin
                result = (n & v) | (~n & ~v);
            end
            `COND_LT : begin
                result = (n & ~v) | (~n & v);
            end

            `COND_GT : begin
                result = ~z & ((n & v) | (~n & ~v));
            end

            `COND_LE : begin
                result = z | ((n & ~v) | (~n & v));
            end

            `COND_AL : begin
                result = 1'b1;
            end
        endcase
    end
endmodule