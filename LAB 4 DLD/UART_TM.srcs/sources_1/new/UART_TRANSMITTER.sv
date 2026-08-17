`timescale 1ns / 1ps

module UART_TRANSMITTER(
    input  logic       bclk,
    input  logic       arst,
    input  logic       start_tx,     // start transmission signal
    input  logic [7:0] d_in,
    output logic       tx_data,
    output logic       tx_status
);

    // Transmitter Hold Register
    logic [7:0] THR;

    // Transmitter Shift Register (start + data + stop)
    logic [9:0] TSR;

    // Bit counter
    logic [3:0] bit_cnt;

    // FSM states
    typedef enum logic [1:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t state;

always_ff @(posedge bclk or posedge arst) begin
    if (arst) begin
        state      <= IDLE;
        tx_data    <= 1'b1;   // UART line idle = HIGH
        tx_status  <= 1'b0;
        THR        <= 8'd0;
        TSR        <= 10'd0;
        bit_cnt    <= 4'd0;
    end 
    else begin

        case(state)

        //--------------------------------
        // IDLE STATE
        //--------------------------------
        IDLE:
        begin
            tx_data   <= 1'b1;
            tx_status <= 1'b0;
            bit_cnt   <= 0;

            if(start_tx) begin
                THR <= d_in;                 // load hold register
                TSR <= {1'b1, d_in, 1'b0};   // stop + data + start
                state <= START;
            end
        end

        //--------------------------------
        // START STATE
        //--------------------------------
        START:
        begin
            tx_status <= 1'b1;

            tx_data <= TSR[0];              // transmit start bit
            TSR <= {1'b1, TSR[9:1]};

            bit_cnt <= bit_cnt + 1;

            state <= DATA;
        end

        //--------------------------------
        // DATA STATE
        //--------------------------------
        DATA:
        begin
            tx_data <= TSR[0];              // transmit LSB first
            TSR <= {1'b1, TSR[9:1]};

            bit_cnt <= bit_cnt + 1;

            if(bit_cnt == 8)
                state <= STOP;
        end

        //--------------------------------
        // STOP STATE
        //--------------------------------
        STOP:
        begin
            tx_data <= 1'b1;                // stop bit
            tx_status <= 1'b0;

            state <= IDLE;
        end

        endcase

    end
end

endmodule