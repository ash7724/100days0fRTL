// Code your design here
module spi_master #(parameter clk_div=4,DATA_WIDTH=16)(
  input clk,
  input reset,
  
  output m_sclk,
  output m_mosi,
  output m_csn,
  input  m_miso,
  
  input  [DATA_WIDTH-1:0] data_in,
  output reg [DATA_WIDTH-1:0] data_out,
  input xfer_en,
);
  
  reg reg_sclk;
  reg reg_mosi;
  reg reg_miso;
  reg reg_csn;
  
  reg [3:0] data_count;
  reg [1:0] state,next;
  localparam idle=0,csn=1,clk_en=2, cs_high=3;
  
  always @(posedge clk) begin
    if(reset)   state<=idle;
    else        state<=next;
  end
  
  always @(*) begin
    next=state;
    case(state)
      idle   : if(xfer_en)   next=csn;
               else          next=idle;
       csn   :               next=clk_en;
      clk_en : if(data_count==DATA_WIDTH-1) next=cs_high;
      cs_high: if(xfer_en)   next=csn;
               else          next=cs_high;
    endcase
  end
  
  always @(posedge m_sclk) begin
    if(reset)
       data_count<=0;
    else if(data_count==DATA_WIDTH-1) 
           data_count<=0;
    else begin
           data_count<=data_count+1'b1;
           data_out[data_count]<=m_miso;
           reg_mosi<=data_in[data_count];
        end    
  end
  
  assign m_mosi =reg_mosi;
  assign m_sclk = state==clk_en ? clk: 1'b0;
  assign m_csn= (state==csn || state==clk_en) ? 1'b0 : 1'b1;
  
endmodule
