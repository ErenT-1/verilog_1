`timescale 1ns/1ps

//1) Design 3-bit up/down counter with a reset feature.
//After count direction = 1, it should perform to count upwards.


module up_down(
    input clk, rst,
    output reg [2:0] counter
    );

    reg count_direction; // 1 for  up, 0 for  down

    initial begin 
        counter = 3'b000;
        count_direction = 1;  
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter = 3'b000; //starts from the bottom
            count_direction = 1; // must go up
        end
        else begin
            if (count_direction) begin
                if(counter == 3'b111) begin
                    count_direction = 0; //changes direction
                end
                else begin
                    counter = counter + 1; //adds up until it reaches 111
                end
            end
            else begin
                if(counter == 3'b000) begin
                    count_direction = 1; //changes direction
                end
                else begin
                    counter = counter - 1; //subtracts until it reaches 000
                end
            end
        end
    end

endmodule
