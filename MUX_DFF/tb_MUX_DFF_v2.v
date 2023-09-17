`timescale 1ns / 1ps

module tb_MUX_DFF_v2();

    // Signals
    reg clk = 0;
    reg E;
    reg R;
    reg L;
    reg w;
    wire Q;

    
    MUX_DFF_v2 uut (
        .clk(clk),
        .E(E),
        .R(R),
        .L(L),
        .w(w),
        .Q(Q)
    );

    
    always #5 clk = ~clk;  

    
    initial begin
        E = 0; R = 0; L = 0; w = 0;
        #10;

        
        L = 1; R = 1; #10;
        R = 0; #10;

        
        L = 0; E = 1; w = 1; #10;
        w = 0; #10;

        
        E = 0; #10;

        $finish;  
    end

    
    initial $monitor($time, " E: %b, R: %b, L: %b, w: %b, Q: %b", E, R, L, w, Q);

endmodule
