`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ashish Kayarkar
// 
// Create Date: 16.04.2025 16:32:14
// Design Name: one_minute_counter
// Module Name: one_minute_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description:  Counts Second Minute and Hour based on clk frequency
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module one_minute_counter #(parameter CLK_PERIOOD=10)(
    input clk,
    input resetn    
    );
    
    ///Considering clk_freq parameter we will modify counter value
    // for 1 Second 100MHz clock -> 1000_000_000ns/10ns =1_0000_0000 =5F5 E100 =27b bit
    // for 1 Second 50MHz clock ->  1000_000_000ns/20ns =5000_0000 =2FAF080 =26b bit
    // 
    
    reg[27:0] count;
    reg[6:0] minute_counter=0;
    reg[6:0] second_counter=0;
    reg[3:0] hour_counter=0;
    reg second_clk;
    reg [27:0] second_count=1000000000/CLK_PERIOOD;
    //parameter period=1/CLK_FREQ;
    parameter MAX_MINUTE_COUNT =59;
  
    always @(posedge clk) begin
      if(!resetn) begin
        second_clk<=0;
        count<=0;
      end
      else begin
        if(count==second_count) begin
          second_clk<=~second_clk;
          count<='h0;
         end
         else
          count<=count+ 'h1;
      end
    end
      
    always @(posedge second_clk) begin
      if(second_counter == MAX_MINUTE_COUNT) begin
         second_counter<='h0;
         if(minute_counter == MAX_MINUTE_COUNT) begin
           minute_counter <='h0;
           hour_counter   <=hour_counter+1'b1;           
         end
         else
           minute_counter <=minute_counter+1'b1;
      end
      else 
           second_counter <=second_counter+1'b1;
    end
endmodule
