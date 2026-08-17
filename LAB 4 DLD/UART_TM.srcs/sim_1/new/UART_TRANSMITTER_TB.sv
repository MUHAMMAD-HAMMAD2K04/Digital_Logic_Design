`timescale 1ns / 1ps

module UART_TRANSMITTER_tb;

logic bclk;
logic arst;
logic start_tx;
logic [7:0] d_in;
logic tx_data;
logic tx_status;

UART_TRANSMITTER dut(
    .bclk(bclk),
    .arst(arst),
    .start_tx(start_tx),
    .d_in(d_in),
    .tx_data(tx_data),
    .tx_status(tx_status)
);

initial
begin
    bclk = 0;
    forever #5 bclk = ~bclk;
end

initial
begin
    arst = 1;
    start_tx = 0;
    d_in = 8'h00;

    #20
    arst = 0;

    #20
    d_in = 8'hA5;
    start_tx = 1;

    #10
    start_tx = 0;

    #200

    d_in = 8'h3C;
    start_tx = 1;

    #10
    start_tx = 0;

    #200

    $finish;
end

endmodule