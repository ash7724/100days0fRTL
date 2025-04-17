`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2025 22:48:18
// Design Name: 
// Module Name: lfsr_parameterized
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description:  //Design and verify a 4-bit linear feedback shift register where  
//               the bit0 of the register is driven by the XOR of the LFSR register bit1 and bit3
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lfsr_parameterized #(N=4)(
    input     wire      clk,
    input     wire      reset,

    output    wire [N-1:0] lfsr_o
);

 reg  [N-1:0] lfsr_reg;
 wire [N-1:0] lfsr_next;
 
 always @(posedge clk) begin
    if(reset)    lfsr_reg<='h1;
    else         lfsr_reg<=lfsr_next;
 end
 
 assign lfsr_next =reset ? 'h0 : {lfsr_reg[N-2:0], lfsr_reg[1]^lfsr_reg[N-2]};
 assign lfsr_o=lfsr_reg;
endmodule
