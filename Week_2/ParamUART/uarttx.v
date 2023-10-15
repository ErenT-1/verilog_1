module uart_tx(
    input clk,
    input rst,
    input [7:0] data,
    input start,
    output reg tx,
    output reg done
);

    parameter IDLE = 0, START = 1, DATA = 2, STOP = 3;
    reg [2:0] state;
    reg [2:0] bit_count;
    reg [7:0] shift_reg;

    initial begin
        tx = 1'b1;
        done = 0;
        state = IDLE;
        bit_count = 0;
        shift_reg = 0;
    end
    
 // this part wil be changed
    
/*
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            tx <= 1'b1;
            done <= 0;
        end else begin
            case(state)
                IDLE:
                    if (start) begin
                        shift_reg <= data;
                        state <= START;
                    end

                START:
                    tx <= 0;  
                    state <= 2;

                DATA:
                    tx <= shift_reg[0];
                    shift_reg <= {1'b0, shift_reg[7:1]};
                    bit_count <= bit_count + 1;
                    if (bit_count == 3'd8) begin
                        state <= STOP;
                    end

                STOP:
                    tx <= 1'b1;  // Send stop bit
                    done <= 1;
                    state <= IDLE;
            endcase
        end
    end

*/
endmodule
