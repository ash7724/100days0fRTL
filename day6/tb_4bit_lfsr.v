`timescale 1ns / 1ps
module tb_lfsr();

  // Write your Testbench here...
    parameter N=6;
    reg       clk;
    reg       reset;
    wire[N-1:0] lfsr_o;

  
lfsr_parameterized #(N) dut(
        clk,
        reset,
        lfsr_o
);
  

  initial begin
    reset<=1'b1;
    #10
    @(posedge clk);
    reset<=1'b0;
  end
  
  always begin
  	#5 clk<=1'b0;
    #5 clk<=1'b1;
  end
  
endmodule
