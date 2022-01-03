module MUX #(parameter LENGTH = 1) (
  input  [LENGTH-1:0] in_1, 
  input  [LENGTH-1:0] in_2, 
  input               select,

  output [LENGTH-1:0] out
);

  assign out = select == 1'b0 ? in_1 : in_2;

endmodule

module MUX3 #(parameter LENGTH = 1) (
  input  [LENGTH-1:0] in_1,
  input  [LENGTH-1:0] in_2,
  input  [LENGTH-1:0] in_3,
  input  [1:0]        select,

  output [LENGTH-1:0] out
);

  assign out = 
    select == 2'b00 ? in_1 :
    select == 2'b01 ? in_2 :
    select == 2'b10 ? in_3 : 32'bz;

endmodule



