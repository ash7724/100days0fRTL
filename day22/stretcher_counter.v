`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2025 23:21:04
// Design Name: 
// Module Name: stretcher_counter
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


module stretcher_counter(
   input    wr_clk,
   input    wr_resetn,
   input    pulse,
   output   reg pulse_out_100
    );
    reg state,next;
    parameter idle=0,state2=1;
    reg [3:0]clk_count;    
    wire pulse_pe,pulse_pe_in,count_en;
    reg   pulse_ff1_100M,pulse_ff2_100M;
    wire  pulse_en_reg;
    wire pulse_reg_100;
      
    //Input pulse synchronization
        always @(posedge wr_clk) begin
            if(!wr_resetn) begin
               pulse_ff1_100M<='h0;
               pulse_ff2_100M<='h0;
            end
            else begin
               pulse_ff1_100M<=pulse;
               pulse_ff2_100M<=pulse_ff1_100M;
            end
        end
    
        // Synchronized pulse positive edge
        assign pulse_pe_in = (pulse_ff1_100M==1'b0 && pulse_ff2_100M==1'b1) ? 1'b1:1'b0;
    
        // State change logic
        always @(posedge wr_clk) begin
            if(!wr_resetn)
                state<=idle;
            else
                state<=next;
        end
    
        // Next State logic
        always@(*) begin
            next=state;
            case(state)
                idle: if (pulse_pe_in==1'b1)  next=state2;
                      else                    next=idle;
                state2:if(clk_count==5)       next=idle;
                       else                   next=state2;
            endcase
        end
    
        // Pulse stretcher
        always @(posedge wr_clk) begin
            case(state)
                idle    : clk_count<='h0;
                state2  : begin
                           if(clk_count==5)    clk_count<='h0;
                           else                clk_count<=clk_count+1'b1;    
                          end
           endcase
        end
    
        // Pulse stretcher
        assign pulse_reg_100= (state==state2) ? 1'b1: 1'b0;
        //  stretched Pulse sent to re ceiver domain
        always @(posedge wr_clk) begin
            pulse_out_100<=pulse_reg_100;
        end
            
endmodule
