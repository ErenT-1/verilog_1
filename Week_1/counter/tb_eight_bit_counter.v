`timescale 1ns / 1ps

module tb_dual_speed_counter();

    reg clk;
    reg rst_n;
    reg sel;
    wire [7:0] count;
    wire [31:0] divider_counter_o;

    dual_speed_counter uut (
        .clk(clk),
        .rst_n(rst_n),
        .sel(sel),
        .count(count),
        .divider_counter_o(divider_counter_o)
    );

    always begin
        #5 clk = ~clk;
    end


    initial begin
        clk = 0;
        rst_n = 0;
        sel = 0;
        
        #10 rst_n = 1; 
        
        #10000000; // 1s 1bit count
        $display("sel = %b, count = %b", sel, count);
        
        sel = 1;
        
        #2500000; // 0.25s  4 bits count
        $display("sel = %b, count = %b", sel, count);
        
        #7500000; 
        $display("sel = %b, count = %b", sel, count);
        
        $stop;
    end

endmodule
