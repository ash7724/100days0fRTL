// Code your design here
module bin_to_gray #(
  parameter VEC_W = 4
)(
  input     wire[VEC_W-1:0] bin_i,
  output    wire[VEC_W-1:0] gray_o

);
  genvar i;
  generate
    for (i=0; i<VEC_W-1;i++) begin
      assign gray_o[i] = bin_i[i] ^ bin_i[i+1];
    end
    assign gray_o[VEC_W-1] = bin_i[VEC_W-1];

  endgenerate
endmodule

module bin_to_gray_tb ();

  // Write your Testbench here...
parameter VEC_W = 4;
  
  logic [VEC_W-1:0] bin_i;
  logic [VEC_W-1:0] gray_o;
  
bin_to_gray #(
   VEC_W 
) dut (
   bin_i,
   gray_o
);
  
initial begin
  $dumpvars();
  $dumpfile("a.vcd");
  repeat (10) 
    #100
    bin_i<=$urandom_range(0,{VEC_W{1'b1}});
    #100
    bin_i<=$urandom_range(0,{VEC_W{1'b1}});
    $monitor("0x%x  0x%x",bin_i, gray_o);
end
  
endmodule
