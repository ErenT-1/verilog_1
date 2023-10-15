`timescale 1ns/1ps

module synch_fifo #(
    parameter RAM_WIDTH = 16,
    parameter RAM_DEPTH = 1024,
    parameter LOG_DEPTH = 10
)(
    input clk,
    input rst_n,   // Reset
    input wr_en,   // Write Enable
    input rd_en,   // Read Enable
    input [RAM_WIDTH-1:0] din,
    output reg [RAM_WIDTH-1:0] dout,
    output reg empty,
    output reg full
);

    reg [RAM_WIDTH-1:0] BRAM [0:RAM_DEPTH-1];
    reg [LOG_DEPTH-1:0] wr_ptr = 0;
    reg [LOG_DEPTH-1:0] rd_ptr = 0;

    initial begin
        for (integer i = 0; i < RAM_DEPTH; i = i + 1) begin
            BRAM[i] = 0;
        end
        dout = 0;
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            empty <= 1;
            full <= 0;
        end else begin
            if (wr_en && !full) begin
                BRAM[wr_ptr] <= din;
                wr_ptr <= (wr_ptr + 1) % RAM_DEPTH;
            end
            if (rd_en && !empty) begin
                dout <= BRAM[rd_ptr];
                rd_ptr <= (rd_ptr + 1) % RAM_DEPTH;
            end
            empty <= (rd_ptr == wr_ptr);
            full <= (rd_ptr == ((wr_ptr + 1) % RAM_DEPTH));
        end
    end

endmodule
