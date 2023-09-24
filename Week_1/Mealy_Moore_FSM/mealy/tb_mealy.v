`timescale 1ns / 1ps

module tb_mealy_fsm();

    reg d_in, clk, rst;
    wire d_out;

    mealy_fsm u1 (
        .d_in(d_in),
        .clk(clk),
        .rst(rst),
        .d_out(d_out)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        rst = 1;  
        #10 rst = 0;  

        
        #20 d_in = 0;
        #10 d_in = 1;
        #10 d_in = 0;
        #10 d_in = 1;
        #10 d_in = 1;

        #50 $finish;  
    end

    
    initial begin
        $monitor("Time = %0dns | d_in = %b | d_out = %b", $time, d_in, d_out);
    end

endmodule
