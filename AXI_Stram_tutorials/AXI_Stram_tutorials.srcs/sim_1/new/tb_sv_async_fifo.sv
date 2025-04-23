`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2025 11:25:08
// Design Name: 
// Module Name: tb_async_fifo
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


module tb_sv_async_fifo(

    );
    parameter DATA_WIDTH=16;
    parameter DEPTH=8;
    reg wr_clk;
    reg resetn;
    reg rd_clk;
    reg wr_en;
    reg rd_en;
    reg  [DATA_WIDTH-1:0] wr_data;
    wire [DATA_WIDTH-1:0] rd_data;
    wire fifo_empty;
    wire fifo_full;
    
    reg [DATA_WIDTH-1:0] wdata;            // Regular register
    reg [DATA_WIDTH-1:0] wdata_q[$];      // Queue of registers
   axis_async_fifo #(DEPTH) dut_asyn_fifo (
       .wr_clk(wr_clk),
       .resetn(resetn),
       .rd_clk(rd_clk),
       .wr_en(wr_en),
       .rd_en(rd_en),
       .wr_data(wr_data),
       .rd_data(rd_data),
       .fifo_empty(fifo_empty),
       .fifo_full(fifo_full)
        );
        
     initial begin
       wr_clk<=0;
       rd_clk<=0;
       resetn<=0;
       wr_en<=0;
       rd_en<=0;
       wr_data<=16'h00;
       #100
       @(posedge wr_clk);
       resetn<=1;
       #100
       repeat(256) begin
        @(posedge wr_clk);
        wr_en<=1;
        wr_data<=$urandom;
        wdata_q.push_back(wr_data);
       end
        wr_en<=0;
       repeat(256) begin
        @(posedge rd_clk);
        rd_en<=1;
        if (rd_en) begin
          wdata = wdata_q.pop_front();
          if(rd_data !== wdata) $error("Time = %0t: Comparison Failed: expected wr_data = %h, rd_data = %h", $time, wdata, rd_data);
          else $display("Time = %0t: Comparison Passed: wr_data = %h and rd_data = %h",$time, wdata, rd_data);
        end        
        @(posedge rd_clk);
        end    
        #100
        rd_en<=0;   
     end
     
     always #10  rd_clk<=~rd_clk;
     always #100 wr_clk<=~wr_clk;
endmodule
