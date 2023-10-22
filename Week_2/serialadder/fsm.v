module Control_FSM (
    input clk,
    input rst,     // Asynchronous reset
    input start,   // Start signal
    output reg load,    // Signal to load data into the shift registers
    output reg enable,  // Enable signal for the shift registers and the addition
    output reg done     // Indicates the addition is complete
);

    reg [1:0] current_state, next_state;
    reg [3:0] counter;  // 4-bit counter to count up to 9 cycles

    // States
    parameter RESET = 2'b00, LOAD = 2'b01, ADD = 2'b10, DONE = 2'b11;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= RESET;
            counter <= 4'b0000;
        end else begin
            current_state <= next_state;
            if (current_state == ADD)
                counter <= counter + 1;
            else
                counter <= 4'b0000;
        end
    end

    always @* begin
        case(current_state)
            RESET: begin
                load = 0;
                enable = 0;
                done = 0;
                if (start)
                    next_state = LOAD;
                else
                    next_state = RESET;
            end

            LOAD: begin
                load = 1;
                enable = 0;
                done = 0;
                next_state = ADD;
            end
            
            ADD: begin
                load = 0;
                enable = 1;
                done = 0;
                if (counter == 4'b1001)  
                    next_state = DONE;
                else
                    next_state = ADD;
            end

            DONE: begin
                load = 0;
                enable = 0;
                done = 1;
                if (start)
                    next_state = LOAD;  
                else
                    next_state = DONE;
            end

        endcase
    end

endmodule

