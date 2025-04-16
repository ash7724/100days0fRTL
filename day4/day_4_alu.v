// A simple ALU

module day4 (
  input     logic [7:0]   a_i,
  input     logic [7:0]   b_i,
  input     logic [2:0]   op_i,

  output    logic [7:0]   alu_o
);

  // Write your logic here...

  always @(a_i,b_i,op_i) begin
    case(op_i)
      3'b000:begin
        alu_o<= a_i + b_i ;
      end
      3'b001:begin
        alu_o<= a_i - b_i ;        
      end
      3'b010:begin
        alu_o <= a_i >>b_i[2:0];
      end
      3'b011:begin
        alu_o <= a_i <<b_i[2:0];
      end    
      3'b100:begin
        alu_o<= a_i & b_i ;
      end
      3'b101:begin
        alu_o<= a_i |  b_i ;
      end
      3'b110:begin
        alu_o<= a_i ^  b_i ;
      end
      3'b111:begin
        for(int i=0;i<=7;i++)
          alu_o[i]<= (a_i[i] == b_i[i]) ? 1'b1 :1'b0 ;        
      end    
    endcase
  end
  
endmodule
