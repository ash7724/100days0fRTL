module b2g_conv #(parameter DEPTH=8) ( 
  input   [DEPTH-1 : 0] bin_num, 
  output  [DEPTH-1 : 0] grey_num 
);
   genvar i;
   generate
     for (i=0; i<DEPTH-1;i=i+1) begin
      assign grey_num[i] = bin_num[i] ^ bin_num[i+1];
     end
   endgenerate;
   assign grey_num[DEPTH-1]= bin_num[DEPTH-1];
endmodule;
