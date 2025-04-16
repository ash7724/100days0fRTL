`timescale 1ns / 1ps
module tb_minute_counter(

    );
    reg clk;
    reg reset;
    wire [7:0] cnt_o;    
   
     odd_counter dut2(
          clk,
          reset,
          cnt_o 
      );
                
     initial begin
       clk<=0;
       reset<=1;
       #100;
       reset<=1'b0;
     end
     always #5 clk<=~clk;
endmodule
