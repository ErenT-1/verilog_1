module tb_top_module();

    reg clk;
    reg rst_n;
    reg fpga_gpio_rx;
    reg fpga_button;
    wire fpga_gpio_tx;
    wire [7:0] fpga_leds;

    top_module dut(
        .clk(clk),
        .rst_n(rst_n),
        .fpga_gpio_rx(fpga_gpio_rx),
        .fpga_button(fpga_button),
        .fpga_gpio_tx(fpga_gpio_tx),
        .fpga_leds(fpga_leds)
    );

    initial begin
        clk = 0;
        rst_n = 0;
        fpga_gpio_rx = 1'b1;
        fpga_button = 1'b0;
        #10 rst_n = 1;
        
        #15 fpga_gpio_rx = 1'b0; 
        #10 fpga_gpio_rx = 1'b1; 
        #10 fpga_gpio_rx = 1'b0; 
        #10 fpga_gpio_rx = 1'b1; 
        #10 fpga_gpio_rx = 1'b0; 
        #10 fpga_gpio_rx = 1'b1; 
        #10 fpga_gpio_rx = 1'b0; 
        #10 fpga_gpio_rx = 1'b1; 
        #10 fpga_gpio_rx = 1'b0; 
        #10 fpga_gpio_rx = 1'b1; 
        
        
        /* letter 'e' shoulad be seen*/
        /* letter 'e' shoulad be seen*/
        #20 fpga_button = 1'b1;
        #10 fpga_button = 1'b0;
        #30; 
       
        #15 fpga_gpio_rx = 1'b0; 
        #10 fpga_gpio_rx = 1'b0; 
        #10 fpga_gpio_rx = 1'b1; 
        #10 fpga_gpio_rx = 1'b0; 
        #10 fpga_gpio_rx = 1'b1; 
        #10 fpga_gpio_rx = 1'b0; 
        #10 fpga_gpio_rx = 1'b1; 
        #10 fpga_gpio_rx = 1'b0; 
        #10 fpga_gpio_rx = 1'b1; 
        #10 fpga_gpio_rx = 1'b1; 

        #20 fpga_button = 1'b1;
        #10 fpga_button = 1'b0;
        #30 $finish; 
    end

    always #5 clk = ~clk;

endmodule
