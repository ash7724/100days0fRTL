// Different DFF

module day2 (
  input     logic      clk,
  input     logic      reset,

  input     logic      d_i,

  output    logic      q_norst_o,
  output    logic      q_syncrst_o,
  output    logic      q_asyncrst_o
);

  // Write your logic here...

  always @(posedge clk) begin
    q_norst_o<= d_i;
  end 
  
  always @(posedge clk or posedge reset) begin
    if(reset)
      q_asyncrst_o <= 1'b0;
    else
      q_asyncrst_o <= d_i;
  end 

  always @(posedge clk) begin
    if(reset)
      q_syncrst_o <= 1'b0;
    else
      q_syncrst_o <= d_i;
  end 
  
endmodule

// DFF TB

module day2_tb ();

  // Write your Testbench here...
      logic      clk;
      logic      reset;
      logic      d_i;
      logic      q_norst_o;
      logic      q_syncrst_o;
      logic      q_asyncrst_o;
  
day2 dut (
       clk,
       reset,
       d_i,
       q_norst_o,
       q_syncrst_o,
       q_asyncrst_o
);  
  
  
  initial begin
   clk=1'b0;
   reset=1'b1;
   d_i=1'b0;
    
  #50
    @(posedge clk); 
    reset=0;
   #10
    
    repeat (10) begin
      @(posedge clk); 
             d_i<=$random;
    end
    
 
  end
  
  always #5 clk=~clk;
endmodule
