`timescale 1ns / 1ps

module DEBOUNCER #(parameter SIM = 0)
(
input  logic reset_in,
input  logic clock_in,
input  logic noisy_in,
output logic clean_out
);

logic [19:0] count;
logic new_input;

localparam integer DEBOUNCE_COUNT = (SIM) ? 50 : 1_000_000;

always_ff @(posedge clock_in)
begin
    if (reset_in)
    begin
        new_input <= noisy_in;
        clean_out <= noisy_in;
        count <= 0;
    end

    else if (noisy_in != new_input)
    begin
        new_input <= noisy_in;
        count <= 0;
    end

    else if (count == DEBOUNCE_COUNT)
        clean_out <= new_input;

    else
        count <= count + 1;
end

endmodule