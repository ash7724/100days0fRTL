`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2025 14:45:39
// Design Name: 
// Module Name: counter_modn
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


module pulse_stretcher #(parameter N=32)(
   input wr_clk,
   input rd_clk,
   input wr_resetn,
   input rd_resetn,
   input pulse,
   output pulse_en,
   output [N-1:0] count
    );
    wire  pulse_en_reg;

    wire pulse_pe,pulse_pe_in,count_en;
    reg   pulse_ff1_100M,pulse_ff2_100M;

    reg state,next;
    parameter idle=0,state2=1;
    reg [3:0]clk_count;
    wire pulse_reg_100;
    reg pulse_out_100;

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
    
    rcv_stretched_pulse #(.N(N)) recv_domain(
       .rd_clk(rd_clk),
       .rd_resetn(rd_resetn),
       .rd_pulse(pulse_out_100),
       .pulse_en(pulse_en),
       .count(count)
        );    
//// counter_approach
//reg [$clog2(N)-1:0] count_reg;
//    always @(posedge clk) begin
//        if(!resetn)     count_reg<='h0;
//        else if(count_reg==N)
//           count_reg<='h0;
//        else
//           count_reg<=count_reg+'h1;
//    end
//    assign pulse_en_reg = (count_reg==31) ? 1'b1 :1'b0;
endmodule
