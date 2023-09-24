module sequence_gen(
    input clk,                
    input rst,              
    output reg [31:0] seq_o   
);

    reg [31:0] num1 = 1;  
    reg [31:0] num2 = 1;  
    reg [31:0] num3 = 1;  
    reg [31:0] numout; 

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            num1 <= 1;
            num2 <= 1;
            num3 <= 1;
            seq_o <= 1;
        end else begin
            numout = num1 + num2;
            num1 <= num2;
            num2 <= num3;
            num3 <= numout;
            seq_o <= numout;
        end
    end

endmodule
