module events_to_apb (
  input clk,
  input reset,
  input event_a_i,
  input event_b_i,
  input event_c_i,
  input apb_pready_i,
  output reg apb_psel_o,
  output reg apb_penable_o,
  output reg [31:0] apb_paddr_o,
  output reg apb_pwrite_o,
  output reg [31:0] apb_pwdata_o
);

  reg [31:0] event_a_count = 32'd0;
  reg [31:0] event_b_count = 32'd0;
  reg [31:0] event_c_count = 32'd0;

  reg start_transaction = 1'b0;
  reg [1:0] event_id = 2'b00;  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      event_a_count <= 32'd0;
      event_b_count <= 32'd0;
      event_c_count <= 32'd0;
    end else begin
      if (event_a_i) event_a_count <= event_a_count + 1;
      if (event_b_i) event_b_count <= event_b_count + 1;
      if (event_c_i) event_c_count <= event_c_count + 1;
    end
  end

  always @(posedge clk) begin
    if (start_transaction) begin
      if (apb_pready_i) begin
        apb_penable_o <= 1'b0;
        start_transaction <= 1'b0;
      end
      else if (!apb_penable_o) begin
        apb_penable_o <= 1'b1;
      end
    end
    else begin
      if (event_a_i) begin
        event_id <= 2'b01;
        start_transaction <= 1'b1;
      end
      else if (event_b_i) begin
        event_id <= 2'b10;
        start_transaction <= 1'b1;
      end
      else if (event_c_i) begin
        event_id <= 2'b11;
        start_transaction <= 1'b1;
      end
    end
  end

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      apb_psel_o <= 1'b0;
      apb_penable_o <= 1'b0;
      apb_paddr_o <= 32'd0;
      apb_pwrite_o <= 1'b1; 
      apb_pwdata_o <= 32'd0;

    // master ~ slave  

    end else begin
      if (start_transaction) begin
        apb_psel_o <= 1'b1;
        case (event_id)
          2'b01: begin
            apb_paddr_o <= 32'hABBA0000;
            apb_pwdata_o <= event_a_count;
          end
          2'b10: begin
            apb_paddr_o <= 32'hBAFF0000;
            apb_pwdata_o <= event_b_count;
          end
          2'b11: begin
            apb_paddr_o <= 32'hCAFE0000;
            apb_pwdata_o <= event_c_count;
          end
        endcase
      end
      else if (apb_pready_i) begin
        apb_psel_o <= 1'b0;
        apb_penable_o <= 1'b0;
      end
    end
  end

endmodule
