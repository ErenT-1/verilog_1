`timescale 1ns/1ps

module singleport #(parameter RAM_WIDTH = 16,parameter RAM_DEPTH = 1024,parameter LOG_DEPTH = 10)
(
    input clk,
    input wr_en,
    input rd_en,
    input [LOG_DEPTH-1:0] addr,
    input [RAM_WIDTH-1:0] din,
    output [RAM_WIDTH-1:0] dout
);

    (* ram_style = "block"*)
    reg [RAM_WIDTH-1:0] ram [RAM_DEPTH-1:0]; //declares array named 'ram' 
    reg [RAM_WIDTH-1:0] ram_data = {RAM_WIDTH{1'b0}}; //initializes the ram_data to 0

    always @(posedge clk ) begin
        if (wr_en == 1) begin
            ram[addr] <= din;   
        end
        if (rd_en == 1) begin
        ram_data <= ram[addr];
        end
    end
    assign dout = ram_data;
endmodule

