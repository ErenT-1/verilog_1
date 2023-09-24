`timescale 1ns / 1ps

module tb_MUX_DFF();

    reg clk = 0;
    reg L;
    reg Rin;
    reg Qin;
    wire Q;

    MUX_DFF uut (
        .clk(clk),
        .L(L),
        .Rin(Rin),
        .Qin(Qin),
        .Q(Q)
    );




    initial begin
        L = 0; Rin = 0; Qin = 0; 
        #10;


        Qin = 1; #10;
        Qin = 0; #10;
        

        L = 1; Rin = 1; #10;
        Rin = 0; #10;

        $finish;  
    end

    initial $monitor($time, " L: %b, Rin: %b, Qin: %b, Q: %b", L, Rin, Qin, Q);

endmodule
