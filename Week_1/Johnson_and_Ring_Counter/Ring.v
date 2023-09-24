`timescale 1ns / 1ps

module Ring_Counter(
    input clk, clr,
    output reg [3:0] Q
    );

    always @(posedge clk or posedge clr) begin
        if (clr) begin
            Q <= 4'b0001;
        end else begin
            if (Q == 4'b1000) begin
                Q <= 4'b0001;
            end else begin
                Q <= Q << 1;
                end
            end
        end

endmodule
