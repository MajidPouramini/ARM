module MUX #(
  parameter LENGTH = 1
  ) (
  input [LENGTH-1:0] in_1, in_2, 
  input select,
  output [LENGTH-1:0] out
);

  assign out = select ? in_1 : in_2;

endmodule



