module day6_tb ();
  parameter DATA_WIDTH=10;
  logic         clk;
  logic         reset;
  logic         x_i;      // Serial input
  logic [DATA_WIDTH-1:0]   sr_o;

  // Write your Testbench here...
  shift_register  #(DATA_WIDTH) dut(
    clk,
    reset,
    x_i,      // Serial input
    sr_o
);

  initial begin
    reset<=1'b1;
    x_i<=1'b0;
    #20
    @(posedge clk);
    reset<=1'b0;
    
    @(posedge clk);
    for (int i=0;i<30;i++)begin
      x_i<=~x_i;
      @(posedge clk);
    end
    
  end
  
  always begin
    #5 clk=1'b0;
    #5 clk=1'b1;
  end
endmodule
