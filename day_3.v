 // An edge detector

module day3 (
  input     wire    clk,
  input     wire    reset,

  input     wire    a_i,

  output    wire    rising_edge_o,
  output    wire    falling_edge_o
);

  // Write your logic here...
  logic reg_a;
  
  always @(posedge clk) begin
    if(reset) 
      reg_a<=a_i;
  end
  
  assign rising_edge_o= ~reg_a & a_i;
  assign falling_edge_o= reg_a & ~a_i;

endmodule

// Simple edge detector TB

module day3_tb ();

 logic  clk;
 logic  reset;
 logic  a_i;
 logic  rising_edge_o;
 logic  falling_edge_o;
  // Write your Testbench here...
  day3 u_dut (.*);
  
initial 
  begin
    reset=1;
    a_i=0;
    #100;
    reset=0;
    #100;
      a_i=1;  
    #100;    
    a_i=0;
    #100;
      a_i=1;  
    
  end
  always 
  begin
    clk=0;
    #50;
    clk=1;
    #50;
  end
     
endmodule
