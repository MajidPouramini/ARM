module TB();
  reg clk = 0;
  reg sram_clk = 0;
  reg rst = 0;

  wire SRAM_WE_N;
  wire [3:0] SW;
  wire [16:0] SRAM_ADDR;
  wire [31:0] SRAM_DQ;
  
  initial begin
    #15 rst = 1;
    #1 rst = 0;
    #10000 $stop;
  end
  
  always begin
    clk = #10 !clk;
  end

  always begin
    sram_clk = #20 !sram_clk;
  end

  assign SW[3] = 1'b1; // Enable/Disable Forwarding Unit
  
  ARM arm_processor (
    .clk(clk), 
    .rst(rst), 
    .SW(SW),

    .SRAM_WE_N(SRAM_WE_N), 
    .SRAM_ADDR(SRAM_ADDR), 

    .SRAM_DQ(SRAM_DQ)
  );

  SRAM sram (
    .clk(sram_clk),
    .rst(rst),
    .SRAM_WE_N(SRAM_WE_N),
    .SRAM_ADDR(SRAM_ADDR),

    .SRAM_DQ(SRAM_DQ)
  );
  
endmodule
