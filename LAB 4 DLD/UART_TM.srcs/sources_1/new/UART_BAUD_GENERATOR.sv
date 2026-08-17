`timescale 1ns / 1ps

module UART_BAUD_GEN(
    input  logic sys_clk,      // 100 MHz system clock
    input  logic arst,         // asynchronous reset
    input  logic [1:0] baud_sel, // 00:9600, 01:19200, 10:38400, 11:57600
    output logic bclk,         // transmitter clock (1× baud)
    output logic bclkx8        // receiver clock (8× baud)
);

logic [10:0] count;   // counts system clocks for bclkx8
logic [2:0]  count8;  // counts bclkx8 pulses for bclk
logic [10:0] divisor; // divisor for selected baud rate

// select divisor based on baud rate
always_comb begin
    case(baud_sel)
        2'b00: divisor = 1302; // 9600 baud
        2'b01: divisor = 651;  // 19200 baud
        2'b10: divisor = 326;  // 38400 baud
        2'b11: divisor = 217;  // 57600 baud
        default: divisor = 1302;
    endcase
end

always_ff @(posedge sys_clk or posedge arst) begin
    if (arst) begin
        count   <= 0;
        count8  <= 0;
        bclkx8  <= 0;
        bclk    <= 0;
    end
    else begin
        bclkx8 <= 0;  // default: 0

        // generate 1-cycle pulse for bclkx8
        if (count == divisor-1) begin
            count <= 0;
            bclkx8 <= 1;  // pulse

            // divide by 8 for bclk (1x baud)
            if (count8 == 3'd7) begin
                count8 <= 0;
                bclk <= 1;   // 1-cycle pulse for bclk
            end
            else begin
                count8 <= count8 + 1;
                bclk <= 0;
            end
        end
        else begin
            count <= count + 1;
            bclk <= 0;
        end
    end
end

endmodule