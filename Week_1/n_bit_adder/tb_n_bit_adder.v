`timescale 1ns / 1ps

module tb_n_bit_adder;

    parameter N = 16;

    reg [N-1:0] A, B;
    reg Cin;
    wire [N-1:0] Sum;
    wire Cout;

    n_bit_adder #(N) uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        
        A = 16'b0000000000000001;
        B = 16'b0000000000000001;
        Cin = 1'b0;
        #10; 


    end

endmodule
