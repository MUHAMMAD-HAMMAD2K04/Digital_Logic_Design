`timescale 1ns / 1ps

module UART_TM(
    input  logic sys_clk,          // 100 MHz system clock
    input  logic arst,             // asynchronous reset
    input  logic [1:0] baud_sel,  // baud selection: 00-9600, 01-19200, 10-38400, 11-57600
    input  logic [7:0] tx_data_in, // data to transmit
    input  logic start_tx,          // start transmission
    
    output logic [7:0] led, // received data
    output logic rx_done,           // receiver status
    output logic tx_busy,           // transmitter busy

    // Physical UART lines for FPGA
    input  logic rx_line,           // receive from external device (Tera Term)
    output logic tx_line            // transmit to external device (Tera Term)
);

    // Internal signals
    logic bclk, bclkx8;
    logic [7:0] rx_data_out;
    
    // Instantiate Baud Generator
    UART_BAUD_GEN baudgen_inst (
        .sys_clk(sys_clk),
        .arst(arst),
        .baud_sel(baud_sel),
        .bclk(bclk),
        .bclkx8(bclkx8)
    );

    // Instantiate Transmitter
    UART_TRANSMITTER tx_inst (
        .bclk(bclk),
        .arst(arst),
        .start_tx(start_tx),
        .d_in(tx_data_in),
        .tx_data(tx_line),   // output to FPGA pin
        .tx_status(tx_busy)
    );

    // Instantiate Receiver
    UART_RECEIVER rx_inst (
        .rx_data(rx_line),   // input from FPGA pin / Tera Term
        .bclkx8(bclkx8),
        .arst(arst),
        .d_out(rx_data_out),
        .rx_status(rx_done)
    );

assign led = rx_data_out;

endmodule