`timescale 1ns/1ps

module dualport #(
    parameter RAM_WIDTH = 16,
    parameter RAM_DEPTH = 1024,
    parameter LOG_DEPTH = 10
)
(
    input clk,
    input wr_en_a,
    input rd_en_b,
    input [LOG_DEPTH-1:0] addra,
    input [LOG_DEPTH-1:0] addrb,
    input [RAM_WIDTH-1:0] dina,
    output reg [RAM_WIDTH-1:0] doutb
);

    reg [RAM_WIDTH-1:0] BRAM [RAM_DEPTH-1:0];

    initial begin
        for(integer i = 0; i < RAM_DEPTH; i = i + 1) begin
            BRAM[i] = 0;
        end
        doutb = 0;
    end

    always @(posedge clk) begin
        if (wr_en_a) begin
            BRAM[addra] <= dina;
        end

        if (rd_en_b) begin
            if (wr_en_a && (addra == addrb)) begin
                doutb <= doutb;
            end else begin
                doutb <= BRAM[addrb];
            end
        end
    end

endmodule
