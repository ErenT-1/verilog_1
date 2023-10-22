`timescale 1ns/1ps

module serial_adder_tb;

    reg clk;
    reg rst;
    reg start;
    reg [7:0] A, B;
    wire [8:0] sum_out;
    wire done;

    serial_adder uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .A(A),
        .B(B),
        .sum_out(sum_out),
        .done(done)
    );

    initial begin
        clk = 0;
        rst = 1;
        start = 0;
        A = 8'b00000000;
        B = 8'b00000000;

        #10 rst = 0;  
        #10;

        // Sum = 8'b01111111
        A = 8'b00101010;
        B = 8'b01010101;
        start = 1;
        #10 start = 0;
        #110;  

        // Reset between tests
        #10 rst = 1;
        #10 rst = 0;

        // Expected Sum = 9'b1000000000
        A = 8'b11111111;
        B = 8'b00000001;
        start = 1;
        #10 start = 0;
        #110;  

        #100 $finish;  
    end

    // Clock generation
    always #5 clk = ~clk;

endmodule
