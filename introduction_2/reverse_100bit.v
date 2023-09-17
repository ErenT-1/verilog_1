module bit_reverse(
    input [99:0] vector_in,
    output [99:0] vector_out
);

always @* begin
    for(int i=0; i<100; i=i+1) begin
        vector_out[i] = vector_in[99-i];
    end
end

endmodule
