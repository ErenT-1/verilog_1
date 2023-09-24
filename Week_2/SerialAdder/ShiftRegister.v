`timescale 1ns / 1ps

module ShiftRegister (
    input [7:0] Din,
    input load,
    input clk,
    input Clear_b,
    output reg [7:0] Din_Next,
    output LSB_out
);

    always @(posedge clk or negedge Clear_b)
    begin
        if (Clear_b == 0) begin
            Din_Next <= 8'b00000000;
        end else if (load) begin
            Din_Next <= Din;
        end else begin
            Din_Next <= {1'b0, Din_Next[7:1]};
        end
    end

    assign LSB_out = Din_Next[0];

endmodule
