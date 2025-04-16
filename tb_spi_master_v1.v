// Code your testbench here
// or browse Examples
module tb_spi;

  parameter clk_div=4,DATA_WIDTH=16;

  logic clk;
  logic reset;
  
  logic m_sclk;
  logic m_mosi;
  logic m_csn;
  logic  m_miso;
  
  logic [DATA_WIDTH-1:0] data_in;
  logic [DATA_WIDTH-1:0] data_out;
  logic xfer_en;
  
  
  spi_master #( clk_div,DATA_WIDTH) dut(
  clk,
  reset,
  m_sclk,
  m_mosi,
  m_csn,
  m_miso,
  data_in,
  data_out,
  xfer_en
);
  initial begin
    $dumpvars();
    $dumpfile("abc.vcd");
    clk=0;
    reset=1;
    xfer_en=0;
    data_in=0;
    m_miso=0;
    #20ns
    @(posedge clk);
    reset=0;
    #20ns
    @(posedge clk);
    xfer_en=1;
    data_in=$urandom_range(0,1024);
    #400ns
    @(posedge clk);
    xfer_en=0;
    #500ns
    $finish();

                           
  end
  always #5ns clk=~clk;
  
endmodule
