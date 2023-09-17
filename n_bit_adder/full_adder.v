`timescale 1ns / 1ps

module full_adder (
    input A, B, Cin,
    output S, Cout
 );
    wire AB, BCin, ACin;

    assign AB = A & B;
    assign BCin = B & Cin;
    assign ACin = A & Cin;

    assign S = A ^ B ^ Cin; //Sum

    assign Cout = AB | BCin |  ACin; //Carry
    
endmodule