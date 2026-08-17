`timescale 1ns / 1ps

module UART_RECEIVER(
    input  logic rx_data,
    input  logic bclkx8,
    input  logic arst,
    output logic [7:0] d_out,
    output logic rx_status
);

logic [7:0] RSR;
logic [3:0] bit_cnt;
logic [2:0] sample_cnt;

typedef enum logic [1:0] {IDLE, START, DATA, STOP} state_t;
state_t state;

always_ff @(posedge bclkx8 or posedge arst) begin

    if(arst) begin
        state <= IDLE;
        RSR <= 0;
        bit_cnt <= 0;
        sample_cnt <= 0;
        d_out <= 0;
        rx_status <= 0;
    end

    else begin

        case(state)

        IDLE:
        begin
            rx_status <= 0;
            bit_cnt <= 0;
            sample_cnt <= 0;

            if(rx_data == 0)
                state <= START;
        end

        START:
        begin
            sample_cnt <= sample_cnt + 1;

            if(sample_cnt == 3) begin
                sample_cnt <= 0;
                state <= DATA;
            end
        end

        DATA:
        begin
            sample_cnt <= sample_cnt + 1;

            if(sample_cnt == 7) begin
                sample_cnt <= 0;

                RSR <= {rx_data,RSR[7:1]};
                bit_cnt <= bit_cnt + 1;

                if(bit_cnt == 7)
                    state <= STOP;
            end
        end

        STOP:
        begin
            sample_cnt <= sample_cnt + 1;

            if(sample_cnt == 7) begin
                sample_cnt <= 0;

                if(rx_data == 1) begin
                    d_out <= RSR;
                    rx_status <= 1;
                end

                state <= IDLE;
            end
        end

        endcase

    end

end

endmodule