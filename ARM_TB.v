module TB();
  reg clk = 0;
  reg rst = 0;
  
  initial begin
    #15 rst = 1;
    #1 rst = 0;
    #6000 $stop;
  end
  
  always begin
    clk = #10 !clk;
  end

  wire [3:0] SW;
  assign SW[3] = 1'b0; // Enable/Disable Forwarding Unit
  
  ARM arm_processor (clk, rst, SW);
  
endmodule
