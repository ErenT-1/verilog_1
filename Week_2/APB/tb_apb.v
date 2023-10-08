module tb_events_to_apb;

  reg clk;
  reg reset;
  reg event_a_i;
  reg event_b_i;
  reg event_c_i;
  wire apb_psel_o;
  wire apb_penable_o;
  wire [31:0] apb_paddr_o;
  wire apb_pwrite_o;
  wire [31:0] apb_pwdata_o;
  reg apb_pready_i;

  events_to_apb dut (
    .clk(clk),
    .reset(reset),
    .event_a_i(event_a_i),
    .event_b_i(event_b_i),
    .event_c_i(event_c_i),
    .apb_psel_o(apb_psel_o),
    .apb_penable_o(apb_penable_o),
    .apb_paddr_o(apb_paddr_o),
    .apb_pwrite_o(apb_pwrite_o),
    .apb_pwdata_o(apb_pwdata_o),
    .apb_pready_i(apb_pready_i)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk; 
  end

  initial begin

    // Reset
    reset = 1;
    event_a_i = 0;
    event_b_i = 0;
    event_c_i = 0;
    apb_pready_i = 0;

    #10 reset = 0;
    #10 event_a_i = 1;  
    #10 event_a_i = 0;
    #10 apb_pready_i = 1; 
    #10 apb_pready_i = 0;
    #10 event_b_i = 1;   
    #10 event_b_i = 0;
    #10 apb_pready_i = 1; 
    #10 apb_pready_i = 0;
    #10 event_b_i = 1;   
    #10 event_b_i = 0;
    #10 apb_pready_i = 1; 
    #10 apb_pready_i = 0;
    #50

    $finish; 
  end

endmodule
