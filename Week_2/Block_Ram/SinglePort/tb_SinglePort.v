module tb_SinglePort #(
    parameter RAM_WIDTH = 16,
    parameter RAM_DEPTH = 1024,
    parameter LOG_DEPTH = 10
)
(
);

    reg clk;
    reg wr_en;
    reg rd_en;  
    reg [LOG_DEPTH-1:0] addr; 
    reg [RAM_WIDTH-1:0] din;
    wire [RAM_WIDTH-1:0] dout;  

    singleport # 
    (
        .RAM_WIDTH (RAM_WIDTH),
        .RAM_DEPTH (RAM_DEPTH),
        .LOG_DEPTH (LOG_DEPTH)
    )
    SinglePort_uut
    (
        .clk (clk),
        .wr_en (wr_en),
        .rd_en (rd_en),  
        .addr (addr),
        .din (din),
        .dout (dout)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        wr_en = 0;
        rd_en = 0;  
        din = 0;
        addr = 0;

        #10; 

        addr = 0;
        din = 16'hAA;
        wr_en = 1;
        #10;

        wr_en = 0;
        #10;
        
        rd_en = 1;
        addr = 0;
        #10;
        
        rd_en = 0;
        #10;
        
        $display("Read addr 0: %h", dout);
        
        addr = 1;
        din = 16'hBB;
        wr_en = 1;
        #10;

        wr_en = 0;
        #10;
        
        rd_en = 1;
        addr = 1;
        #10;
        
        rd_en = 0;
        #10;

        $display("Read addr 1: %h", dout);

        $finish;
    end

endmodule
