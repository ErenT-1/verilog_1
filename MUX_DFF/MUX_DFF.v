`timescale 1ns / 1ps

module MUX_DFF(
    input clk, L, Rin, Qin,
    output reg Q
    );
    always @(posedge clk) begin
        if (!L) begin
            Q <= Qin;
            end
        else begin
            Q <= Rin;
            end
        end
endmodule