`timescale 1ns / 1ps

module half_bit_adder(
    input A,B,
    output S,C
    );
    
    assign S = A ^ B; //Sum
    assign C = A & B; //Carry 
    
    
endmodule
