`timescale 1ns / 1ps

module dff(q,d,clk);
input d,clk;
output q;
reg q;
initial begin
q=1'b0;
end
always @(posedge clk)
begin
q=d;
end
endmodule