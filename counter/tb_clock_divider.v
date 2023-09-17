`timescale 1ns/1ps

module tb_clock_dividers_2_and_4;

// Testbench signals
reg clk_tb = 0;
reg rst_tb = 0;
reg freq_tb = 0;
wire clk_div2_tb;
wire clk_div4_tb;

clock_dividers_2_and_4 u1 (
    .clk(clk_tb),
    .rst(rst_tb),
    .freq(freq_tb),
    .clk_div2(clk_div2_tb),
    .clk_div4(clk_div4_tb)
);

// Clock generation
always begin
    #5 clk_tb = ~clk_tb; 
end

initial begin
    rst_tb = 1;
    #10 rst_tb = 0;
    #20 freq_tb = 0;
    #100 freq_tb = 1;
    #200 $finish;
end

endmodule
