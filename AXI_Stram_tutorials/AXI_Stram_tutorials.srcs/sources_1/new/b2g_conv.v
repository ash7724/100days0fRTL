`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2025 00:11:34
// Design Name: 
// Module Name: b2g_conv
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
module b2g_conv #(parameter DEPTH=8) ( 
  input   [DEPTH : 0] bin_num, 
  output  [DEPTH : 0] grey_num 
);
   genvar i;
   generate
     for (i=0; i<DEPTH;i=i+1) begin
      assign grey_num[i] = bin_num[i] ^ bin_num[i+1];
     end
   endgenerate;
   assign grey_num[DEPTH]= bin_num[DEPTH];
endmodule