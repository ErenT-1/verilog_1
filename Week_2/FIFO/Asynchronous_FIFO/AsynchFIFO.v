module fifo (
    input wr_clk,
    input wr_en,
    input [DATA_WIDTH-1:0] din,
    output full,

    input rd_clk,
    input rd_en,
    output reg [DATA_WIDTH-1:0] dout,
    output empty
);

    parameter DATA_WIDTH = 8;
    parameter ADDRESS_WIDTH = 4;
    parameter FIFO_DEPTH = (1 << ADDRESS_WIDTH);

    reg [DATA_WIDTH-1:0] ram [0:FIFO_DEPTH-1];
    reg [ADDRESS_WIDTH-1:0] wr_ptr = 0;
    reg [ADDRESS_WIDTH-1:0] rd_ptr = 0;
    reg [ADDRESS_WIDTH-1:0] wr_ptr_gray = 0;
    reg [ADDRESS_WIDTH-1:0] rd_ptr_gray = 0;

    function [ADDRESS_WIDTH-1:0] binary_to_gray(input [ADDRESS_WIDTH-1:0] bin);
        binary_to_gray = bin ^ (bin >> 1);
    endfunction

    always @(posedge wr_clk) begin
        if (wr_en && !full) begin
            ram[wr_ptr] <= din;
            wr_ptr <= wr_ptr + 1'b1;
        end
    end

    always @(posedge rd_clk) begin
        if (rd_en && !empty) begin
            dout <= ram[rd_ptr];
            rd_ptr <= rd_ptr + 1'b1;
        end
    end

    always @(wr_ptr) begin
        wr_ptr_gray = binary_to_gray(wr_ptr);
    end

    always @(rd_ptr) begin
        rd_ptr_gray = binary_to_gray(rd_ptr);
    end

    assign full = (wr_ptr_gray == rd_ptr_gray - 1) || 
                  (wr_ptr_gray == FIFO_DEPTH-1 && rd_ptr_gray == 0) ? 1'b1 : 1'b0;
    assign empty = (wr_ptr_gray == rd_ptr_gray) ? 1'b1 : 1'b0;

endmodule