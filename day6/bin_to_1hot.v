// Binary to one-hot

module day8#(
  parameter BIN_W       = 4,
  parameter ONE_HOT_W   = 16
)(
  input   wire[BIN_W-1:0]     bin_i,
  output  wire[ONE_HOT_W-1:0] one_hot_o
);

  // Write your logic here...
  assign one_hot_o=1<<bin_i;
endmodule

module day8_tb();

  // Write your Testbench here...
  parameter BIN_W       = 4;
  parameter ONE_HOT_W   = 16;
  reg [BIN_W-1:0]     bin_i;
  wire[ONE_HOT_W-1:0] one_hot_o;
  
 day8 #(
   BIN_W,
   ONE_HOT_W
 ) dut (
     bin_i,
     one_hot_o
 );
   initial begin
       bin_i<='h0;     
     repeat (4) begin 
       #100       
       bin_i<=$urandom_range(0,15);     
     end
   end
endmodule
