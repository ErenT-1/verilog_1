module sipo(
    input clk,    
    input rst,    
    input enable, 
    input din,    
    output [8:0] dout 
);

    reg [8:0] memory = 9'b000000000;

    always @(posedge clk or posedge rst) begin
        if (rst) 
            memory <= 9'b000000000; 
        else if (enable) 
            memory <= {din, memory[8:1]}; 
    end

    assign dout = memory;

endmodule
