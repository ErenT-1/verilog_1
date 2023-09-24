`timescale 1ns / 1ps

module tb_clk_divider_led();

    reg clk = 0;
    reg rst;
    reg [1:0] switch;
    wire led;

    clk_divider_led #(27) uut (
        .clk(clk),
        .rst(rst),
        .switch(switch),
        .led(led)
    );

    
    always #5 clk = ~clk;  

    initial begin
        rst = 1; #10;
        rst = 0;

        switch = 2'b00; #20;
        switch = 2'b01; #20;
        switch = 2'b10; #20;
        switch = 2'b11; #20;

        $finish;  
    end

    initial $monitor($time, " Switch: %b, LED: %b", switch, led);

endmodule
