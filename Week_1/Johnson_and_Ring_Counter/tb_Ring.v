`timescale 1ns / 1ps

module tb_Ring_Counter();
    reg clk;
    reg clr;


    wire [3:0] Q;
    Ring_Counter U0 (
        .clk(clk), 
        .clr(clr), 
        .Q(Q)
    );

    always begin
        #5 clk = ~clk;   
    end

    // Testbench stimulus
    initial begin
        clk = 0;  
        clr = 0;  
        #10; 
        clr = 1;  
        #10;
        clr = 0;  
        #50;  
        $stop;  
    end
endmodule