`timescale 1ns / 1ps

module mealy_fsm(
    input d_in, clk, rst,
    output reg d_out
);

    reg [3:0] state, next_state;

    parameter S0 = 4'b0000, 
              S1 = 4'b0001,
              S2 = 4'b0010,
              S3 = 4'b0011;

    always @(posedge clk or negedge rst) begin
        if (rst) begin
            state <= S0;
            d_out <= 0;  
        end else begin
            state <= next_state;
        end
    end

    always @(state, d_in) begin
        case (state)
            S0:
                if (d_in == 1) begin
                    next_state <= S1;
                    d_out <= 0;
                end else begin
                    next_state <= S0;
                    d_out <= 0;
                end
          
            S1:
                if (d_in == 0) begin
                    next_state <= S2;
                    d_out <= 0;
                end else begin
                    next_state <= S1;
                    d_out <= 0;
                end
            S2:
                if (d_in == 1) begin
                    next_state <= S3;
                    d_out <= 0;
                end else begin
                    next_state <= S0;
                    d_out <= 0;
                end
            S3:
                if (d_in == 1) begin
                    next_state <= S1;
                    d_out <= 1;
                end else begin
                    next_state <= S2;
                    d_out <= 0;
                end
        endcase
    end
endmodule
