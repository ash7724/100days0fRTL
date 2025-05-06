/*
Design the following sequence generator module:

0 ? 1 ? 1 ? 1 ? 2 ? 2 ? 3 ? 4 ? 5 ? 7 ? 9 ? 12 ? 16 ? 21 ? 28 ? 37 ? ...

Assume the sequence goes on forever until the circuit is reset. 
All the flops should be positive edge triggered with asynchronous resets (if any).

The generator should produce output every cycle
You can assume that the sequence generator would never overflow

  // Detecting a big sequence - 1110_1101_1011

*/
module seq_generator (
  input           clk,
  input           reset,
  input           x_i,

  output          det_o,
  output   [31:0] seq_o
);
   
  // Detecting a big sequence - 1110_1101_1011
  // Write your logic here...
  
  parameter s_0=0,
  			 s_1=1, 
             s_11=2,
             s_111=3,
             s_1110=4,
  			 s_1110_1=5,
             s_1110_11=6,
             s_1110_110=7,
             s_1110_1101=8,
  			 s_1110_1101_1=9,
             s_1110_1101_10=10,
             s_1110_1101_101=11,
  			 s_1110_1101_1011=12;
  
  reg [3:0] present_state, next_state;
  reg det_reg;// Detecting a big sequence - 1110_1101_1011
  
  reg [3:0] state, next;   
  reg [31:0] seq_reg_a,seq_reg_b,seq_reg_next;

    always @(posedge clk) begin
        if(reset)   state<=s_0;
        else        state<=next;
    end
    
    always@(*) begin
        case(state)
          s_0:          if(x_i)  next=s_1;
                        else     next=s_0;
          s_1:          if(x_i)  next=s_11;
                        else     next=s_0;
          s_11:         if(x_i)  next=s_111;
                        else     next=s_0; 
          s_111:        if(!x_i) next=s_1110;
                        else     next=s_111;
          s_1110:       if(x_i)  next=s_1110_1;
                        else     next=s_0;                                                                                    
          s_1110_1:     if(x_i)  next=s_1110_11;
                        else     next=s_0;
          s_1110_11:    if(!x_i) next=s_1110_110;
                        else     next=s_111;
          s_1110_110:   if(x_i)  next=s_1110_1101;
                        else     next=s_0; 
          s_1110_1101:  if(x_i) next=s_1110_1101_1;
                        else     next=s_0;
          s_1110_1101_1:if(!x_i)  next=s_1110_1101_10;
                        else     next=s_111;
          s_1110_1101_10:if(x_i) next=s_1110_1101_101;
                         else    next=s_0;
          s_1110_1101_101:if(x_i)next=s_11;
                          else   next=s_0;
          default:               next=s_0;
        endcase;
    end
    
    always @(posedge clk) begin
        det_reg<=0;
        case(next)
        s_1110_1101_101:  det_reg<=1'b1;
        endcase
    end
    assign det_o= det_reg;
    
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
