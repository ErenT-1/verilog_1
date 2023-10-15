module top_module(
    input clk,
    input rst_n,
    input fpga_gpio_rx,
    input fpga_button,
    output fpga_gpio_tx,
    output [7:0] fpga_leds
);
    wire fifo_write_enable;
    wire fifo_read_enable = fpga_button;  // Read from FIFO when the FPGA button is pressed
    wire [7:0] fifo_data_out;
    wire fifo_empty;
    reg [7:0] uart_tx_data = 8'h65;  // ASCII for "e"
    wire uart_rx_data_valid;

    uart_rx uart_rx_inst(
        .clk(clk),
        .rst(~rst_n),
        .rx(fpga_gpio_rx),
        .data_out(fifo_data_out),
        .data_valid(uart_rx_data_valid)
    );

    uart_tx uart_tx_inst(
        .clk(clk),
        .rst(~rst_n),
        .data_in(uart_tx_data),
        .send_data(fifo_empty),
        .tx(fpga_gpio_tx),
        .tx_done()
    );

    synch_fifo fifo_inst(
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(uart_rx_data_valid),
        .rd_en(fifo_read_enable),
        .din(fifo_data_out),
        .dout(fpga_leds),
        .empty(fifo_empty),
        .full()
    );

endmodule
