`timescale 1ns/1ps

module tb_truedualport #(
    parameter RAM_WIDTH = 16,
    parameter RAM_DEPTH = 1024,
    parameter LOG_DEPTH = 10
)
(
);

    reg clk;
    reg wr_en_a, wr_en_b;
    reg rd_en_a, rd_en_b;
    reg [LOG_DEPTH-1:0] addra;
    reg [LOG_DEPTH-1:0] addrb;
    reg [RAM_WIDTH-1:0] dina;
    reg [RAM_WIDTH-1:0] dinb;
    wire [RAM_WIDTH-1:0] douta;
    wire [RAM_WIDTH-1:0] doutb;

    truedualport #(
        .RAM_WIDTH(RAM_WIDTH),
        .RAM_DEPTH(RAM_DEPTH),
        .LOG_DEPTH(LOG_DEPTH)
    ) uut (
        .clk(clk),
        .wr_en_a(wr_en_a),
        .wr_en_b(wr_en_b),
        .rd_en_a(rd_en_a),
        .rd_en_b(rd_en_b),
        .addra(addra),
        .addrb(addrb),
        .dina(dina),
        .dinb(dinb),
        .douta(douta),
        .doutb(doutb)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        wr_en_a = 0;
        wr_en_b = 0;
        rd_en_a = 0;
        rd_en_b = 0;
        addra = 0;
        addrb = 0;
        dina = 0;
        dinb = 0;
        #10;

        wr_en_a = 1;
        dina = 16'hAAAA;
        addra = 4;
        #10;

        wr_en_b = 1;
        dinb = 16'hBBBB;
        addrb = 5;
        #10;

        wr_en_a = 0;
        rd_en_a = 1;
        #10;

        wr_en_b = 0;
        rd_en_b = 1;
        #10;


        wr_en_a = 1;
        rd_en_b = 1;
        addra = 6;
        addrb = 4;
        dina = 16'hCCCC;
        #10;

        $finish;
    end
endmodule
