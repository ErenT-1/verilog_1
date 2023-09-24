`timescale 1ns / 1ps

module serial_adder (
    input [7:0] A,          // 8-bit input A
    input [7:0] B,          // 8-bit input B
    input go,               // Start signal
    input CLK,              // Clock signal
    input Clear_b,          // Clear signal
    output reg [8:0] sum    // 9-bit sum output
);

    // Internal signals
    reg Cin;
    wire Cout;
    wire LSB_A;
    wire LSB_B;
    wire LSB_sum;
    reg [1:0] state;
    reg [1:0] next_state;

    // Instantiate modules
    full_adder FA (
        .A(LSB_A),
        .B(LSB_B),
        .Cin(Cin),
        .S(LSB_sum),
        .Cout(Cout)
    );

    Shift_Register_8_right_shift_till_zero shift_reg_A (
        .Din(A),
        .load(go),
        .CLK(CLK),
        .Clear_b(Clear_b),
        .A_par(),
        .LSB_out(LSB_A)
    );

    Shift_Register_8_right_shift_till_zero shift_reg_B (
        .Din(B),
        .load(go),
        .CLK(CLK),
        .Clear_b(Clear_b),
        .A_par(),
        .LSB_out(LSB_B)
    );

    // State Machine Logic
    always @(posedge CLK or negedge Clear_b) begin
        if (Clear_b == 0) begin
            state <= 2'b00;  // Reset state to idle
            Cin <= 0;        // Reset carry-in
            sum <= 0;        // Reset sum
        end else if (go) begin
            state <= 2'b01;  // Go to addition state
            Cin <= 0;        // Reset carry-in for new addition
            sum <= 0;        // Reset sum for new addition
        end else begin
            state <= next_state;
        end
    end

    always @(state, go, Cout) begin
        case(state)
            2'b00:  // Idle
                if (go) begin
                    next_state <= 2'b01;  // Go to addition state
                end else begin
                    next_state <= 2'b00;  // Stay in idle state
                end
            2'b01:  // Addition
                next_state <= 2'b00;  // Return to idle state for simplicity
        endcase
    end

    // Perform Addition and Update Sum Register
    always @(posedge CLK or negedge Clear_b) begin
        if (Clear_b == 0) begin
            sum <= 0;
        end else if (state == 2'b01) begin
            sum <= {Cout, sum[8:1]};  // Update sum register
            Cin <= Cout;              // Update carry-in
        end
    end

endmodule
