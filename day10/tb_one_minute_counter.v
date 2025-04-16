`timescale 1ns / 1ps
module tb_minute_counter(

    );
    reg clk;
    reg resetn;
    parameter CLK_PERIOD=10000;
one_minute_counter #( CLK_PERIOD)dut(
         clk,
         resetn    
        );
     
     initial begin
       clk<=0;
       resetn<=0;
       #100;
       resetn<=1'b1;
       
     end
     always #5 clk<=~clk;
endmodule
