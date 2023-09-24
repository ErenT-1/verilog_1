`timescale 1ns / 1ps

// Behavioral description of an 8-bit right-shift-till-zero register
module Shift_Register_8_right_shift_till_zero (
    input [7:0] Din,         
    input load,              
    input CLK,               
    input Clear_b,           
    output reg [7:0] A_par,  
    output LSB_out          
);

    always @(posedge CLK or negedge Clear_b)
    begin
        if (Clear_b == 0) begin
            A_par <= 8'b00000000;  // Reset the 8-bit register to all zeros
        end else if (load) begin
            A_par <= Din;  // Load the 8-bit input into the shift register
        end else begin
            A_par <= {1'b0, A_par[7:1]};  // Perform right shifting
        end
    end

    assign LSB_out = A_par[0];  // Assign the least significant bit to the output

endmodule
