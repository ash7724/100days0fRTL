`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 20:23:19
// Design Name: 
// Module Name: dff_sync
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

module dff_sync #(parameter DEPTH=8) ( 
  input   clk, 
  input   resetn, 
  input   [DEPTH-1 : 0] data_in, 
  output  [DEPTH-1 : 0] data_out 
);
 reg [DEPTH-1 : 0] data_dff1 ;
 reg [DEPTH-1 : 0] data_dff2 ;
 /// Read pointer sync in wr clock domain
   always @(posedge clk) begin
     if(!resetn) begin
       data_dff1 <=0;
       data_dff2 <=0;
     end
     else begin
       data_dff1  <=data_in;
       data_dff2  <=data_dff1;
     end
   end
   assign data_out=data_dff2;
endmodule
