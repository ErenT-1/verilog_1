`timescale 1ns / 1ps

module tb_serial_adder;

    reg [7:0] A;
    reg [7:0] B;
    reg go;
    reg CLK;
    reg Clear_b;
    wire [8:0] sum;

    // Instantiate the serial_adder
    serial_adder uut (
        .A(A),
        .B(B),
        .go(go),
        .CLK(CLK),
        .Clear_b(Clear_b),
        .sum(sum)
    );

    // Clock generation
    always begin
        #5 CLK = ~CLK;
    end

    // Stimulus
    initial begin
        // Initialize signals
        A = 8'h0;
        B = 8'h0;
        go = 0;
        CLK = 0;
        Clear_b = 1;

        #10;

        // Test 1: Add 3 + 4
        A = 8'h03;
        B = 8'h04;
        go = 1;
        
        #10;

        go = 0;

        // Wait and observe sum
        #50;

        // Test 2: Add 255 + 255
        A = 8'hFF;
        B = 8'hFF;
        go = 1;

        #10;
        
        go = 0;

        // Wait and observe sum
        #50;

        $finish;
    end

    // Add a process to display the output sum for debugging
    initial begin
        $monitor("At time %t, sum = %h", $time, sum);
    end

endmodule
