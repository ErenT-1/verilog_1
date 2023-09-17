module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
    
    wire w1; //left top gate
    wire w2; // left bottom gate
    wire w3; // right top gate
    wire w4; // right bottom gate
    
    assign w1 = p2a & p2b;
    assign w2 = p2c & p2d;
    assign w3 = p1a & p1b & p1c;
    assign w4 = p1d & p1e & p1f;
    
    assign p2y = w1 | w2;
    assign p1y = w3 | w4;


endmodule