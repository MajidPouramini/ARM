module TB();
  reg clk = 0;
  reg rst = 0;
  
  initial begin
    #15 rst = 1;
    #1 rst = 0;
    #1000 $stop;
  end
  
  always begin
    clk = #10 !clk;
  end
  
  ARM arm_processor (clk, rst);
  
endmodule
