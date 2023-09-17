`timescale 1ns / 1ps

module clk_divider_led #(parameter N = 27)(
    input clk,
    input rst,
    input [1:0] switch,
    output reg led
);

wire [N-1:0] din;
wire [N-1:0] clkdiv;

assign din = ~clkdiv;


generate 
    for (int i = 0; i < N; i=i+1) begin
        dff dff_base (
            .clk((i == 0) ? clk : clkdiv[i-1]), 
            .rst(rst),
            .D(din[i]),
            .Q(clkdiv[i])
        );
    end
endgenerate;


always @* begin
    case (switch)
        2'b00: 
            led = clkdiv[N-1];  //0.745 Hz blink frequency
        2'b01: 
            led = clkdiv[N-2];  //1.49 Hz blink frequency
        2'b10: 
            led = clkdiv[N-3];  //2.98 Hz blink frequency
        2'b11: 
            led = clkdiv[N-4];  // 5.96 Hz blink frequency
        default: 
            led = 1'b0;
    endcase;
end

endmodule





