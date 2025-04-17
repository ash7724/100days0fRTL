//Design and verify a simple shift register

// Simple shift register
module shift_Register #(DATA_WIDTH=4)(
  input     wire        clk,
  input     wire        reset,
  input     wire        x_i,      // Serial input

  output    reg [DATA_WIDTH-1:0]   sr_o
);

  reg [DATA_WIDTH-1:0]   shift_next;
  always @(posedge clk) begin
    if(reset)   sr_o<='h0;
    else        sr_o<=shift_next;
  end

  always @(posedge clk) begin
    if(reset)    shift_next<='h0;
    else         shift_next<={shift_next[DATA_WIDTH-2:0],x_i};
  end
  
endmodule
