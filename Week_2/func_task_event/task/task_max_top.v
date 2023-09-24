`timescale 1ns/1ps

module task_max_top;

    reg [7:0] a = 8'b10011111;
    reg [7:0] b = 8'b11000001;
    wire [7:0] c;

    task_max uut(
        .a(a),
        .b(b),
        .c(c)
    );

initial begin
    #50
    a = 8'b10010011;
    b = 8'b10010111;

    #50
    a = 8'b11010011;
    b = 8'b10010111;

    #50
    a = 8'b11111111;
    b = 8'b11111111;

    #50
    a = 8'b00000000;
    b = 8'b00000001;

    #100
    $finish;
end

endmodule