`timescale 1ns / 1ps

module MUX_DFF_v2(
    input clk, E, R, L, w,
    output reg Q
);

always @(posedge clk) begin
    if (L) begin
        Q <= R;
    end 
    else if (E) begin
        Q <= w;
    end 
    else begin
        Q <= Q;
    end
end

endmodule
