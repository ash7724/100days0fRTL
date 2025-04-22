
module g2b_conv #(parameter DEPTH=8) ( 
  input   [DEPTH : 0] grey_num, 
  output  [DEPTH : 0] bin_num 
);
   genvar i;
   generate
     for (i=0; i<=DEPTH;i=i+1) begin
      assign bin_num[i] = ^(grey_num >> i);
     end
   endgenerate;

endmodule;
