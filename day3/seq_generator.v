/*
Design the following sequence generator module:

0 → 1 → 1 → 1 → 2 → 2 → 3 → 4 → 5 → 7 → 9 → 12 → 16 → 21 → 28 → 37 → ...

Assume the sequence goes on forever until the circuit is reset. 
All the flops should be positive edge triggered with asynchronous resets (if any).

The generator should produce output every cycle
You can assume that the sequence generator would never overflow

*/
module seq_generator (
  input           clk,
  input           reset,

  output   [31:0] seq_o
);
    
    reg [31:0] seq_reg_a,seq_reg_b,seq_reg_next;

    
    always @(posedge clk) begin
        if(reset) begin
            seq_reg_a<='h0;
            seq_reg_b<=32'h00000001;
        end
        else begin 
            seq_reg_a<=seq_reg_next;
            seq_reg_b<=seq_reg_a;
        end
    end

    always @(posedge clk) begin
        if(reset)
            seq_reg_next<='h0;
        else 
            seq_reg_next<=seq_reg_a+seq_reg_b ;
    end
    assign seq_o=seq_reg_a;
endmodule
