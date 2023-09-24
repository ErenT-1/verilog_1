`timescale 1ns / 1ps

module tb_moore_fsm();

    reg d_in;
    reg clk;
    reg rst;
    wire d_out;

    moore_fsm u0 (
        .d_in(d_in),
        .clk(clk),
        .rst(rst),
        .d_out(d_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 0;
        d_in = 0;
        #10 rst = 1;
        #10 d_in = 1;
        #10 d_in = 0;
        #10 d_in = 1;
        #10 d_in = 1;
        #10 d_in = 0;
        #10 d_in = 1;
        #10 d_in = 1;
        #50 $finish;
    end

endmodule
