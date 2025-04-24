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
   input sel,
   input pulse,
   output pulse_en,
   output [N-1:0] count
    );

    wire  pulse_out_100;
    reg   pulse_ff1_100M,pulse_ff2_100M;
    reg   pulse_ff3_100M,pulse_ff4_100M;
    wire  pulse_out_slr;
    reg   pulse_in_30M;
        // SLR approach : Pulse stretching without using SLR
        always @(posedge wr_clk) begin
            if(!wr_resetn) begin
               pulse_ff1_100M<='h0;
               pulse_ff2_100M<='h0;
               pulse_ff3_100M<='h0;
               pulse_ff4_100M<='h0;
            end
            else begin
               pulse_ff1_100M<=pulse;
               pulse_ff2_100M<=pulse_ff1_100M;
               pulse_ff3_100M<=pulse_ff2_100M;
               pulse_ff4_100M<=pulse_ff3_100M;
            end
        end
     
     assign pulse_out_slr=pulse| pulse_ff1_100M |  pulse_ff2_100M | pulse_ff3_100M | pulse_ff4_100M;
     //assign pulse_in_30M=sel? pulse_out_100 : pulse_out_slr;
     always @(posedge wr_clk) begin
        if(!wr_resetn)
            pulse_in_30M<=0;
        else if(sel)
            pulse_in_30M<=pulse_out_100;
        else
            pulse_in_30M<=pulse_out_slr;
     end
    ///Pulse stretcher using state machine
    stretcher_counter pulse_stretcher(
           .wr_clk(wr_clk),
           .wr_resetn(wr_resetn),
           .pulse(pulse),
           .pulse_out_100(pulse_out_100)
     );
    
    rcv_stretched_pulse #(.N(N)) recv_domain(
       .rd_clk(rd_clk),
       .rd_resetn(rd_resetn),
       .rd_pulse(pulse_in_30M),
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
