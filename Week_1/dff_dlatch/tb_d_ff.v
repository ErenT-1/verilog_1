`timescale 1ns / 1ps

module tb_dff;

    reg clk;
    reg resetn;
    reg [1:0] byteena;
    reg [15:0] D;
    wire [15:0] Q;

    d_ff uut (
        .clk(clk),
        .resetn(resetn),
        .byteena(byteena),
        .D(D),
        .Q(Q)
    );

    initial begin
        clk = 0;
        resetn = 0;
        byteena = 2'b00;
        D = 16'b0;

        #10 resetn = 1;
        #10 D = 16'b1010101010101010; byteena = 2'b11; 
        #10 D = 16'b1100110011001100; byteena = 2'b10; 
        #10 D = 16'b1111000011110000; byteena = 2'b01; 
        #10 $finish;
    end

    always #5 clk = ~clk;

endmodule