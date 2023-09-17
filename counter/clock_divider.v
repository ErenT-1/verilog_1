`timescale 1ns/1ps

module clock_dividers_2_and_4 (
    input clk, rst,
    input freq,
    output reg clk_div2,
    output reg clk_div4
    );

reg [1:0] counter = 2'b00;

always @(posedge clk or posedge rst) 
begin
    if (rst) begin
        counter <= 2'b00;
        clk_div2 <= 0;
        clk_div4 <= 0;
    end 
    else begin
        counter <= counter + 1'b1;
        if (!freq) begin
            clk_div2 <= counter[0]; // clk/2
        end
        else begin
        if (counter == 2'b11) 
            clk_div4 <= !clk_div4; // clk/4
        end
    end
end

endmodule