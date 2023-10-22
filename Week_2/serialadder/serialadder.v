module serial_adder (
    input clk,
    input rst,
    input start,
    input [7:0] A, B,
    output [8:0] sum_out,
    output done
);

    wire load, enable;
    wire sum_bit, carry_out, A_out, B_out;
    reg [8:0] sum_reg = 9'b000000000;
    reg carry_in = 0;

    // Control FSM Instance
    Control_FSM fsm (
        .clk(clk),
        .rst(rst),
        .start(start),
        .load(load),
        .enable(enable),
        .done(done)
    );

    // Shift registers for A and B 
    piso srA (.clk(clk), .enable(enable), .rst(load), .data(A), .out(A_out));
    piso srB (.clk(clk), .enable(enable), .rst(load), .data(B), .out(B_out));

    // Full Adder Instance
    full_adder fa (
        .a(A_out),
        .b(B_out),
        .cin(carry_in),
        .sum(sum_bit),
        .cout(carry_out)
    );

    // Serial-In Parallel-Out shift register for Sum
    sipo srSum (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .din(sum_bit),
        .dout(sum_out)
    );

    // Logic to feed carry_out to carry_in and to store the sum
    always @(posedge clk or posedge rst) begin
        if (rst)
            carry_in <= 0;  // Reset carry_in
        else if (enable) 
            carry_in <= carry_out;  // Update carry_in with carry_out from full_adder
    end

endmodule
