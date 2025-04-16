module counter_module #(parameter VALUE=999) (
  input  clk,
  input  resetn,
  output pulse_out
    );
    

    reg [9:0] count_val;
    always @(posedge clk) begin
      if(!resetn)
          count_val<='h0;
      else if(count_val==VALUE)
          count_val<='h0;
      else
          count_val<=count_val+1'b1;
    end
    
    assign pulse_out=(count_val==VALUE);
endmodule


`timescale 1ns / 1ps
module tb_minute_counter(

    );
    reg clk;
    reg resetn;
    parameter CLK_PERIOD=10000;
    parameter VALUE=999;
    
    
    counter_module #( VALUE)dut(
         clk,
         resetn,
         pulse_out 
        );
     
     initial begin
       clk<=0;
       resetn<=0;
       #100;
       resetn<=1'b1;
       
     end
     always #5 clk<=~clk;
endmodule
