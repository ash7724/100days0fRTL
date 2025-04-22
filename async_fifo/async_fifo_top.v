`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2025 09:50:12
// Design Name: 
// Module Name: axis_async_fifo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module axis_async_fifo #(parameter DEPTH=8)(
  
  input wr_clk,
  input resetn,
  input rd_clk,
  input wr_en,
  input rd_en,
  input  [15:0] wr_data,
  output [15:0] rd_data,
  output fifo_empty,
  output fifo_afull
    );
    
  //parameter PTR_WIDTH = $clog2(DEPTH); 
  reg [15:0] memory_block [0:2**DEPTH-1];
  reg  [DEPTH: 0] wr_pointer,rd_pointer;
  wire [DEPTH: 0] wr_ptr_nxt,rd_ptr_nxt;
  wire [DEPTH: 0] wr_pointer_sync,rd_pointer_sync;
  //reg [DEPTH-1: 0] wr_pointer_sync,rd_pointer_sync;
  //reg [DEPTH-1: 0] wr_pointer_reg,rd_pointer_reg;
  wire [DEPTH: 0] wr_pointer_reg2,rd_pointer_reg2;  
  wire [DEPTH: 0] wr_pointer_bin,rd_pointer_bin;

  wire fifo_full;
  reg  r_fifo_full;
  //assign fifo_full  = wr_pointer== {~rd_pointer_bin[DEPTH-1:0],rd_pointer_bin[DEPTH-2:0]};
  assign fifo_full = wr_pointer==2**DEPTH-1;
  assign fifo_afull = wr_pointer==2**DEPTH-3;
  assign fifo_empty = rd_pointer_sync==wr_pointer_reg2? 1'b1 :1'b0;
  
  //Reading and Writing Data to and from memory
  assign rd_data = (rd_en && !fifo_empty) ?  memory_block[rd_pointer]: 0;
  always @(posedge wr_clk) begin
    if (wr_en)
      memory_block[wr_pointer]<= wr_data;
  end   
 
 //Converting read and write pointer into grey code
    
 /// Write pointer sync in rd clock domain
 b2g_conv #(.DEPTH(DEPTH)) b2g_wr_inst (
  .bin_num(wr_pointer),
  .grey_num(wr_pointer_sync)
 );
 
 g2b_conv #(.DEPTH(DEPTH)) g2b_wr_inst (
  .grey_num(wr_pointer_sync),
  .bin_num(wr_pointer_bin)
 );

 b2g_conv #(.DEPTH(DEPTH)) b2g_rd_inst (
  .bin_num(rd_pointer),
  .grey_num(rd_pointer_sync)
 );
 
 g2b_conv  #(.DEPTH(DEPTH))g2b_rd_inst (
  .grey_num(rd_pointer_reg2),
  .bin_num(rd_pointer_bin)
 );   
 
  dff_sync #(.DEPTH(DEPTH)) wr_sync (
   .clk(rd_clk),
   .resetn(resetn),
   .data_in(wr_pointer_sync),
   .data_out(wr_pointer_reg2)
  );

 /// Read pointer sync in wr clock domain
 dff_sync #(.DEPTH(DEPTH)) rd_sync (
   .clk(wr_clk),
   .resetn(resetn),
   .data_in(rd_pointer_sync),
   .data_out(rd_pointer_reg2)
  );

  assign wr_ptr_nxt = wr_pointer + ((wr_en && !r_fifo_full) ? 1 : 0);
  always @(posedge wr_clk) begin
    if(!resetn)  
            r_fifo_full <='h0;
    else
            r_fifo_full <=fifo_full;
  end  
  always @(posedge wr_clk) begin
    if(!resetn)  
            wr_pointer <='h0;
    else
            wr_pointer <=wr_ptr_nxt;
  end
 
//Read Pointer Increment logic 
  assign rd_ptr_nxt =rd_pointer + (rd_en && !fifo_empty);

  always @(posedge rd_clk) begin
    if(!resetn)     rd_pointer<='h0;
    else            rd_pointer<=rd_ptr_nxt;
  end

endmodule
