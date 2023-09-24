`timescale 1ns/1ps

module zero_counter(
    input [7:0] a,
    output reg [3:0] b
);

    function [3:0] zero_counter_byte(input [7:0] a_in);
        reg [3:0] b_out;
        begin
            b_out = 0;
            for (integer i = 0; i < 8; i = i + 1) begin
                if (a_in[i] == 0) begin
                    b_out = b_out + 1;
                end
            end
            zero_counter_byte = b_out;
        end 
    endfunction

    always @(a) begin
        b = zero_counter_byte(a);    
    end

endmodule
