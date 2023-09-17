`timescale 1ns / 1ps

module d_ff (
    input clk, resetn,
    input [1:0] byteena,
    input [15:0] D,
    output reg [15:0] Q
);

always @(posedge clk) begin
    if (!resetn) begin
        Q <= 16'b0;
    end else begin
        if (byteena[1]) begin
            Q[15:8] <= D[15:8];
        end
        if (byteena[0]) begin
            Q[7:0] <= D[7:0];
        end
    end
end
endmodule