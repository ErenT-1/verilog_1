module top_module (
    input clk,        
    input rst,        
    output reg a,     
    output reg b      
);

initial begin
    a = 1'b1;  
    b = 1'b0;  
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        a <= 1'b0;
        b <= 1'b0;
    end else begin
        a <= b;
        b <= a;
    end
end

endmodule
