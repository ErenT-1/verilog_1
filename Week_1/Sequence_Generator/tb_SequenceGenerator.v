module tb_padovan_sequence;
  
  reg clk;
  reg rst;
  wire [31:0] seq_o;

  sequence_gen uut (
    .clk(clk),
    .rst(rst),
    .seq_o(seq_o)
  );

  always begin
    #5 clk = ~clk;
  end

  initial begin
    clk = 0;
    rst = 0;

    rst = 0;  #10;
    rst = 1;  #10;

    #1000

    $finish;
  end

endmodule
