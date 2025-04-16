//Design and verify an 8-bit odd counter
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2025 21:40:45
// Design Name: 
// Module Name: odd_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description:  
// Design and verify an 8-bit odd counter
// 
// Interface Definition
// Counter should reset to a value of 8'h1
// Counter should increment by 2 on every cycle
// The module should have the following interface:// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module odd_counter(
input     wire        clk,
input     wire        reset,

output    wire [7:0]  cnt_o
    );
  
  reg [7:0] count_val;
  always @(posedge clk) begin
    if(reset)
        count_val<='h1;
    else 
        count_val<=count_val+'h2;
  end
  
  assign cnt_o=count_val;
endmodule

