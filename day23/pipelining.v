module pipelined_multiplier (
    input wire clk,
    input wire rst,
    input wire [7:0] a,
    input wire [7:0] b,
    output reg [15:0] result
);
    reg [15:0] mult_stage;

    always @(posedge clk or posedge rst) begin
        if (rst)
            mult_stage <= 16'd0;
        else
            mult_stage <= a * b;
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            result <= 16'd0;
        else
            result <= mult_stage;
    end
endmodule


module heavy_operation (
    input wire clk,
    input wire rst,
    input wire [15:0] data_in,
    output reg [15:0] data_out
);
    reg [15:0] temp;

    always @(posedge clk or posedge rst) begin
        if (rst)
            temp <= 16'd0;
        else
            temp <= (data_in * 3 + 8) / 2;
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            data_out <= 16'd0;
        else
            data_out <= temp;
    end
endmodule


module logic_chain (
    input wire clk,
    input wire rst,
    input wire [3:0] in,
    output reg [3:0] out
);
    reg [3:0] stage1, stage2;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            stage1 <= 4'd0;
            stage2 <= 4'd0;
            out <= 4'd0;
        end else begin
            stage1 <= (in ^ 4'b1010) + 4'd1;
            stage2 <= (stage1 & 4'b1100) | 4'b0011;
            out <= ~stage2;
        end
    end
endmodule

//reset synchronization
    always @(posedge clk or negedge rst) begin
        if (!rst)
            data_out1 <= 'd0;
        else
            data_out1 <= 1'b1;
    end

    always @(posedge clk or negedge rst) begin
        if (!rst)
            data_out2 <= 1'd0;
        else
            data_out2 <= data_out1 ;
    end

	
