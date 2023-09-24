`timescale 1ns / 1ps

module full_adder (
    input A,          // Input bit A
    input B,          // Input bit B
    input Cin,        // Input carry
    output S,         // Output sum
    output Cout       // Output carry
);

    assign S = A ^ B ^ Cin;                      
    assign Cout = (A & B) | (Cin & (A ^ B));     

endmodule
