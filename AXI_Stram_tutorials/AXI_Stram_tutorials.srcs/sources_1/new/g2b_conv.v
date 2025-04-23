`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2025 00:13:09
// Design Name: 
// Module Name: g2b_conv
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


module g2b_conv #(parameter DEPTH=8) ( 
  input   [DEPTH : 0] grey_num, 
  output  [DEPTH : 0] bin_num 
);
   genvar i;
   generate
     for (i=0; i<=DEPTH;i=i+1) begin
      assign bin_num[i] = ^(grey_num >> i);
     end
   endgenerate;

endmodule
