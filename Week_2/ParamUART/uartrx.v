module uart_rx(
    input clk,               // System Clock
    input rst,               // System Reset
    input rx,                // UART RX line
    output reg[7:0] data,    // Received data byte
    output reg done = 0      // Indicates if data was received
);

    parameter IDLE = 0, START = 1, DATA = 2, STOP = 3;
    reg[2:0] state = IDLE;
    reg[2:0] bit_count = 0;
    reg[7:0] shift_reg;
    
// this part wil be changed
/*
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            bit_count <= 0;
            done <= 0;
        end else begin
            case(state)
                IDLE:
                    if (!rx) begin  // Detect start bit
                        state <= START;
                    end

                START: 
                    state <= DATA;

                DATA: 
                    shift_reg <= {rx, shift_reg[7:1]};  // Shift in bits
                    bit_count <= bit_count + 1;
                    if (bit_count == 3'd8) begin
                        state <= STOP;
                    end

                STOP: 
                    if (rx) begin  // Stop bit is high
                        data <= shift_reg;
                        done <= 1;
                        state <= IDLE;
                    end
            endcase
        end
    end
*/
endmodule
