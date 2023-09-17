`timescale 1ns / 1ps

module n_bit_adder #(parameter N = 16) (
    input [N-1:0] A,B,
    input Cin, // starting carry carry
    output [N-1:0] Sum,
    output Cout
);

wire [N:0] Cin_2; // for carry in inside

assign Cin_2[0] = Cin;

genvar i;
generate for(i = 0; i < N; i = i+1) begin
    full_adder fa(
        .A(A[i]),
        .B(B[i]),
        .Cin(Cin_2[i]),
        .S(Sum[i]),
        .Cout(Cin_2[i+1])
        );
        end
    endgenerate
 


endmodule