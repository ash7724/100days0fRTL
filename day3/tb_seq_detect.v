`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2025 16:57:48
// Design Name: 
// Module Name: tb_fancy_timer
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


module tb_fancy_timer(    );
    
        reg clk;
        reg reset;      // Synchronous reset
        reg data;
        wire [3:0] count;
        reg [15:0] val= 16'b1110_1101_1011_1110;
        reg [3:0] val_count;
        reg [3:0] shift_count=4'b0001;
        wire counting;
        wire done;
        reg ack;
        reg x_i;
        wire det_o;
        wire shift_en;
        wire [31:0] seq_o;
       
  seq_generator u_seq_gen(
          clk,
          reset,
          x_i,
          det_o,
          seq_o
        );
 
  fancy_timer u_timer(
            clk,
            reset,      // Synchronous reset
            data,
            count,
            counting,
            shift_en,
            done,
            ack );
                 
  always @(posedge clk) begin
    if(reset)
        val_count<=15;
    else
        val_count<=val_count-1'b1;
  end
  always @(posedge clk) begin
    if(reset)
        x_i<=0;
    else
        x_i<=val[val_count];
  end               
                 
 initial begin
    $monitor ("\n %x\t  %x\t  %x\t  %x\t",x_i,val[val_count],val_count,det_o);
    clk<=0;
    reset<=1;
    data<=0;
    ack<=0;
    @(posedge clk);
    reset<=0;
    repeat(5) begin
    ///Send data 1101
    @(posedge clk);
    data<=1;
    @(posedge clk);
    data<=1;
    @(posedge clk);
    data<=0;
    @(posedge clk);
    data<=1;    
            
    @(posedge clk);
    data<=shift_count[3];
    @(posedge clk);
    data<=shift_count[2];
    @(posedge clk);
    data<=shift_count[1];
    @(posedge clk);
    data<=shift_count[0];
    
    @(posedge done);
     ack<=1;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
        
  end    
 end
 always #10 clk<=~clk;
 
endmodule
