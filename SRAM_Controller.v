module SRAM_Controller (
  input              clk,
  input              rst,

  input              write_en,
  input              read_en,
  input    [31:0]    address,
  input    [31:0]    writeData, 

  output   [31:0]    readData,

  output             ready,
  
  output   [16:0]    SRAM_ADDR,
  output             SRAM_UB_N,
  output             SRAM_LB_N,
  output             SRAM_WE_N,
  output             SRAM_CE_N,
  output             SRAM_OE_N,

  inout    [31:0]    SRAM_DQ      
);

assign SRAM_UB_N = 1'b0;
assign SRAM_LB_N = 1'b0;
assign SRAM_CE_N = 1'b0;
assign SRAM_OE_N = 1'b0;
    

wire [31:0] base_address;
assign base_address = address - 1024;

wire [16:0] final_address;
assign final_address = base_address[17:2];
    
wire [1:0] present_state, next_state;
parameter IDLE_STATE = 2'b00, READ_STATE = 2'b01, WRITE_STATE = 2'b10;
    
wire [2:0] sram_counter, sram_next_counter;

Register2 present_state_reg(clk, rst, next_state, present_state);
Register3 sram_counter_reg(clk, rst, sram_next_counter, sram_counter);
    
assign next_state = (present_state == IDLE_STATE && read_en) ? READ_STATE :
			(present_state == IDLE_STATE && write_en) ? WRITE_STATE :
                	(present_state == READ_STATE && sram_counter != 3'd5) ? READ_STATE :
                	(present_state == WRITE_STATE && sram_counter != 3'd5) ? WRITE_STATE :
                	IDLE_STATE;
    
assign sram_next_counter = (present_state == READ_STATE && sram_counter != 3'd5) ? sram_counter + 1 :
                          	(present_state == WRITE_STATE && sram_counter != 3'd5) ? sram_counter + 1 :
                          	3'b0;

assign ready = (present_state == READ_STATE && sram_counter != 3'd5) ? 1'b0 :
                   	(present_state == WRITE_STATE && sram_counter != 3'd5) ? 1'b0 :
                   	((present_state == IDLE_STATE) && (read_en || write_en)) ? 1'b0 :
                   	1'b1;

assign SRAM_DQ = (present_state == WRITE_STATE && sram_counter != 3'd5) ? writeData : 32'bz;
    
assign SRAM_WE_N = (present_state == WRITE_STATE && sram_counter != 3'd5) ? 1'b0 : 1'b1;
    
assign SRAM_ADDR = final_address;
    
assign readData = SRAM_DQ;
    
endmodule
