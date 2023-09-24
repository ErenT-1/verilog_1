`timescale 1ns/1ps

module tb_sync_fifo();

    reg clk;
    reg rst_n;
    reg wr_en;
    reg rd_en;
    reg [15:0] din;
    wire [15:0] dout;
    wire empty;
    wire full;

    // Instantiate the sync_fifo module
    sync_fifo #(16, 1024, 10) fifo_inst (
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

    // Test Sequence
    initial begin
        // Initialize signals
        rst_n = 0;
        wr_en = 0;
        rd_en = 0;
        din = 0;

        // Reset the FIFO
        #10 rst_n = 1;
        #10 rst_n = 0;
        #10 rst_n = 1;

        // Test write and read
        #20 wr_en = 1; din = 16'hA1;
        #10 wr_en = 0;
        #20 rd_en = 1;
        #10 rd_en = 0;

        // Test if empty
        if (empty) $display("FIFO is empty");

        // Test write
        #20 wr_en = 1; din = 16'hB2;
        #10 wr_en = 0;

        // Test read
        #20 rd_en = 1;
        #10 rd_en = 0;

            
        #200
    
        // Test if empty again
        if (empty) $display("FIFO is empty");

        
        // End of test
        $finish;
    end
endmodule
