`timescale 1ns / 1ps

module tb_Johnson_Counter();

    reg clk;
    reg clr;
    wire [3:0] Q;

    Johnson_Counter U0 (
        .clk(clk), 
        .clr(clr), 
        .Q(Q)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;   
    end

    // Testbench stimulus
    initial begin
        clk = 0;  // Initialize clock to low
        clr = 0;  // Start with clear de-asserted
        #10; 
        clr = 1;  // Assert clear to reset the counter
        #10;
        clr = 0;  // De-assert clear to let the counter run
        #50;      // Let the counter run for a while 
        $stop;    // Stop the simulation  
    end

endmodule