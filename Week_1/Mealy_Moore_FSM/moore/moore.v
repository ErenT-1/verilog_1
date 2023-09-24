`timescale 1ns / 1ps

module moore_fsm(
    input d_in, clk, rst,
    output reg d_out
    );

    reg [3:0] state;
    parameter S0 = 4'b0000, 
              S1 = 4'b0001,
              S2 = 4'b0010,
              S3 = 4'b0011,
              S4 = 4'b0100;
    always @(posedge clk or posedge rst) begin
        if (!rst) begin
            state <= S0;  
        end else case(state)
            S0:
                if (d_in == 1) begin
                    state <= S1;
                end else begin
                   state <= S0;
                end 
            S1:
                if (d_in == 0) begin
                    state <= S2;
                end else begin
                   state <= S1;
                end
            S2:
            if (d_in == 1) begin
                    state <= S3;
                end else begin
                   state <= S0;
                end
            S3:
                if (d_in == 1) begin
                    state <= S4;
                end else begin
                   state <= S2;
                end
            S4:
            if (d_in == 1) begin
                    state <= S1;
                end else begin
                   state <= S2;
                end
        endcase
        end
    always @(state) begin
        if (state == S4) begin
            d_out = 1;
        end else begin
            d_out = 0;
        end
    end
endmodule