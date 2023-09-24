`timescale 1ns / 1ps


module SinglePortRam(
    input clk,
    input wr_en,
    input rd_en,
    input [clogb2(RAM_DEPTH-1)-1:0] addr;
    input [RAM_WIDTH-1:0] din;
    output [RAM_WIDTH-1:0] dout;   
);

parameter RAM_WIDTH = 16;
parameter RAM_DEPTH = 1024;

(* ram_style = "block"*)
reg [RAM_WIDTH-1:0] BRAM [RAM_DEPTH-1:0];
reg [RAM_WIDTH-1:0] ram_data = {RAM_WIDTH{1'b0}};

always @(posedge clk) begin
    if (we_i==1) begin
        BRAM[addr] <= din;
    end
    ram_data <= BRAM[addr];
end
assign dout = ram_data;

function integer clogb2;
input integer depth;
    for (clogb2=0; depth > 0; clogb2=clogb2+1)
        depth = depth >>1;
endfunction

endmodule