module SRAM_Controller(
  input clk, rst, write_en, read_en,
  input [31:0] address, write_data,

  output ready, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N,
  output [16:0] SRAM_ADDR,
  output [31:0] read_data,

  inout [31:0] SRAM_DQ
);

  assign SRAM_UB_N = 1'b0;
  assign SRAM_LB_N = 1'b0;
  assign SRAM_CE_N = 1'b0;
  assign SRAM_OE_N = 1'b0;
      
  wire [31:0] base_address;
  assign base_address = address - 1024;

  wire [16:0] final_address;
  assign final_address = base_address[17:2];
      
  reg [1:0] present_state, next_state;
  parameter IDLE_STATE = 2'b00, READ_STATE = 2'b01, WRITE_STATE = 2'b10;
      
  reg [2:0] sram_counter, sram_next_counter;

  always @(posedge clk, posedge rst) begin
    if (rst) begin
      present_state <= 0;
      sram_counter <= 0;
    end
    else begin
      present_state <= next_state;
      sram_counter <= sram_next_counter;
    end
  end
      
  always @(*) begin
    next_state <= (present_state == IDLE_STATE && read_en) 
      ? READ_STATE 
      : (present_state == IDLE_STATE && write_en) 
        ? WRITE_STATE 
        : (present_state == READ_STATE && sram_counter != 3'd5) 
          ? READ_STATE 
          : (present_state == WRITE_STATE && sram_counter != 3'd5) 
            ? WRITE_STATE 
            : IDLE_STATE;

    sram_next_counter <= (present_state == READ_STATE && sram_counter != 3'd5) 
      ? sram_counter + 1 
      : (present_state == WRITE_STATE && sram_counter != 3'd5) 
        ? sram_counter + 1 
        : 3'b0;
  end

  assign ready = (present_state == READ_STATE && sram_counter != 3'd5) 
    ? 1'b0 
    : (present_state == WRITE_STATE && sram_counter != 3'd5) 
      ? 1'b0 
      : ((present_state == IDLE_STATE) && (read_en || write_en)) 
        ? 1'b0 
        : 1'b1;

  assign SRAM_DQ = (present_state == WRITE_STATE && sram_counter != 3'd5) ? write_data : 32'bz;
  assign SRAM_WE_N = (present_state == WRITE_STATE && sram_counter != 3'd5) ? 1'b0 : 1'b1;
  assign SRAM_ADDR = final_address;
  assign read_data = SRAM_DQ;
  
endmodule