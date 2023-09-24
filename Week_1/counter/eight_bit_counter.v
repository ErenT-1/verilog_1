`timescale 1ns / 1ps

module dual_speed_counter (
    input clk,  
    input rst_n,    
    input sel, 
    output reg [7:0] count,
    output [31:0] divider_counter_o
);

    reg [31:0] divider_counter = 32'd0;  

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= 8'b00000000;
            divider_counter <= 32'd0;
        end else begin
            divider_counter <= divider_counter + 1'b1;
            if (sel == 0) begin
                if (divider_counter == 100000000 - 1) begin // 1bit at 1s
                    count <= count + 1'b1;
                    divider_counter <= 32'd0;
                end

            end else if (sel == 1) begin
                if (divider_counter == 100000000 - 1) begin //4bit at 1s
                    count <= count + 4'b0100;
                    divider_counter <= 32'd0;
                end

               
            end
        end
    end
    assign divider_counter_o = divider_counter;
endmodule

