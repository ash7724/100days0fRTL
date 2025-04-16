`timescale 1ns / 1ps
//Create a parameterized counter that supports any width.
module MOD_N_Counter #(parameter N=3) (
  input  clk,
  input  resetn,
  output pulse_out,
  output pulse_out_wire_50  //output with 50% duty cycle;
    );
    

    reg [$clog2(N)-1:0] count_val;
    reg pulse_out_wire,pulse_out_wire_n;
    //wire pulse_out_wire_50;

    always @(posedge clk) begin
      if(!resetn) begin
          count_val<='h0;
          pulse_out_wire<=1'b0;                    
      end
      else if(count_val==N-1) begin
          count_val<='h0;
          pulse_out_wire<=1'b1;          
      end
      else begin
          count_val<=count_val+1'b1;
          pulse_out_wire<=1'b0;                              
      end
    end
    
    assign pulse_out=pulse_out_wire;
    
    always @(negedge clk) begin
      pulse_out_wire_n<=pulse_out_wire;
    end
    assign pulse_out_wire_50= pulse_out_wire || pulse_out_wire_n;
    
endmodule
