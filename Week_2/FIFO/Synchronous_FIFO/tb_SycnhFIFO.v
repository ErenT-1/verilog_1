`timescale 1ns/1ps

module tb_synch_fifo();

    parameter RAM_WIDTH = 16;
    parameter RAM_DEPTH = 1024;

    reg clk;
    reg rst_n;
    reg wr_en;
    reg rd_en;
    reg [RAM_WIDTH-1:0] din;
    wire [RAM_WIDTH-1:0] dout;
    wire empty;
    wire full;

    // Instantiate the FIFO
    synch_fifo #(
        .RAM_WIDTH(RAM_WIDTH),
        .RAM_DEPTH(RAM_DEPTH),
        .LOG_DEPTH(10)
    ) fifo_inst (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full)
    );

    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        rst_n = 0;
        wr_en = 0;
        rd_en = 0;
        din = 0;

        #10 rst_n = 1;
        #10;

        // Test for EMPTY situation
        rd_en = 1;
        #10; 
        if (!empty) $fatal("FIFO should be empty!");
        rd_en = 0;
        #10;

        // Test write
        wr_en = 1;
        for (integer i = 0; i < 10; i = i + 1) begin
            din = i;
            #10;
        end
        wr_en = 0;

        #10;

        // Test read
        rd_en = 1;
        for (integer j = 0; j < 10; j = j + 1) begin
            #10;
        end
        rd_en = 0;
        #20;

        // Test for FULL situation
        wr_en = 1;
        for (integer k = 0; k < RAM_DEPTH; k = k + 1) begin
            din = k;
            #10;
        end
        if (!full) $fatal("FIFO should be full!");
        wr_en = 0;

        $finish;
    end

endmodule
