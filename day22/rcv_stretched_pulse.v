`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2025 18:30:27
// Design Name: 
// Module Name: rcv_stretched_pulse
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module rcv_stretched_pulse #(parameter N=32) (
   input rd_clk,
   input rd_resetn,
   input rd_pulse,
   output reg pulse_en,
   output [N-1:0] count
    );

    reg   pulse_ff1,pulse_ff2;
    reg [N-1:0] slr_reg ;
    reg state_rd,next_rd;
    parameter idle=0,state2=1;
// SLR approach
    
        always @(posedge rd_clk) begin
            if(!rd_resetn) begin
               pulse_ff1<='h0;
               pulse_ff2<='h0;
            end
            else begin
               pulse_ff1<=rd_pulse;
               pulse_ff2<=pulse_ff1;
            end
        end
        assign pulse_pe = (pulse_ff1==1'b0 && pulse_ff2==1'b1) ? 1'b1:1'b0;
    
        // State change logic
        always @(posedge rd_clk) begin
            if(!rd_resetn)
                state_rd<=idle;
            else
                state_rd<=next_rd;
        end
    
        // Next State logic
        always@(*) begin
            next_rd=state_rd;
            case(state_rd)
                idle: if (pulse_pe==1'b1)  next_rd=state2;
                      else                 next_rd=idle;
                state2:if(!rd_resetn)      next_rd=idle;
                       else                next_rd=state2;
            endcase
        end
        
        assign count_en = (state_rd==state2)?1'b1:1'b0;
        always @(posedge rd_clk) begin
            if(!rd_resetn)     
               slr_reg<= { 1'b1 , {N-1{1'b0}}};
            else if( count_en && (slr_reg == 'h1))
               slr_reg<= { 1'b1 , {N-1{1'b0}}};
            else if (count_en)
              slr_reg<= slr_reg>>1;
        end
        assign count= slr_reg; 
    
        assign pulse_en_reg = (slr_reg[1]);
        always @(posedge rd_clk) begin
            pulse_en<=pulse_en_reg;
        end    
endmodule
