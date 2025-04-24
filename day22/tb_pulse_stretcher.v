`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2025 22:52:55
// Design Name: 
// Module Name: tb_lfsr
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


module tb_pulse_stretcher();

  // Write your Testbench here...
    parameter N_mod=32;    
    reg       wr_clk;
    reg       reset;
    wire      pulse_en;
    wire [N_mod-1:0] count;
    reg pulse;
    reg rd_clk;
    reg rd_resetn;
  

pulse_stretcher #(.N(N_mod)) dut_clk_div(
   .wr_clk(wr_clk),
   .rd_clk(rd_clk),
   .wr_resetn(~reset),
   .rd_resetn(rd_resetn),
   .pulse(pulse),
   .pulse_en(pulse_en),
   .count(count)
    );
    
  initial begin
    reset<=1'b1;
    pulse<=1'b0;
    rd_resetn<=1'b0;
    #10
    @(posedge wr_clk);
    reset<=1'b0;
    #100
    @(posedge wr_clk);
        pulse<=1'b1;
    @(posedge wr_clk);
        pulse<=1'b0; 
    @(posedge rd_clk);
        rd_resetn<=1'b1;  
  end
  
  always begin
  	#5 wr_clk<=1'b0;
    #5 wr_clk<=1'b1;
  end

  always begin
      #25 rd_clk<=1'b0;
      #25 rd_clk<=1'b1;
  end  
endmodule
