`timescale 1ns / 1ps

module Johnson_Counter(
    input clk, clr,
    output reg [3:0] Q
    );

   always @(posedge clk or posedge clr) begin
        if (clr) begin 
            Q <= 4'b0000;
        end else begin
            Q[3] <= Q[2];
            Q[2] <= Q[1];
            Q[1] <= Q[0];
            Q[0] <= ~Q[3];
            end
        end
endmodule
