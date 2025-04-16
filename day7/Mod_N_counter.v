`timescale 1ns / 1ps

module MOD_N_Counter #(parameter N=3) (
  input  clk,
  input  resetn,
  output pulse_out
    );
    

    reg [$clog2(N)-1:0] count_val;
    always @(posedge clk) begin
      if(!resetn)
          count_val<='h0;
      else if(count_val==N-1)
          count_val<='h0;
      else
          count_val<=count_val+1'b1;
    end
    
    assign pulse_out=(count_val==N);
endmodule
