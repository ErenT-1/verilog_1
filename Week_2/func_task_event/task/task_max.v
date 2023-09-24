`timescale 1ns/1ps

module task_max(
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] c
    );



    task compare_byte (input [7:0] num1, num2, output reg [7:0] bigger);
        begin
            for (integer i = 7; i > -1; i = i -1) begin
                if (num1[i] > num2[i]) begin
                    bigger = num1;
                end else if (num1[i] < num2[i]) begin
                    bigger = num2;
                end else begin
                    bigger = num1;
                end
            end
        end
    endtask

    always @* begin
       compare_byte(a, b, c); 
    end


endmodule