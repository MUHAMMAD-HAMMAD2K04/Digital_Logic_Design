`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2026 01:45:27 PM
// Design Name: 
// Module Name: UART_TOP_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module UART_TM_TB;

    // System signals
    logic sys_clk;
    logic arst;

    // Top module inputs
    logic [1:0] baud_sel;
    logic [7:0] tx_data_in;
    logic start_tx;

    // Top module outputs
    logic [7:0] led;
    logic rx_done;
    logic tx_busy;

    // UART lines
    logic rx_line;
    logic tx_line;

    //----------------------------------
    // Instantiate the UART Top Module
    //----------------------------------
    UART_TM uut (
        .sys_clk(sys_clk),
        .arst(arst),
        .baud_sel(baud_sel),
        .tx_data_in(tx_data_in),
        .start_tx(start_tx),
        .led(led),
        .rx_done(rx_done),
        .tx_busy(tx_busy),
        .rx_line(rx_line),
        .tx_line(tx_line)
    );

    //----------------------------------
    // Clock Generation: 100 MHz
    //----------------------------------
    initial begin
        sys_clk = 0;
        forever #5 sys_clk = ~sys_clk;  // 10 ns period
    end

    //----------------------------------
    // Stimulus
    //----------------------------------
    initial begin
        // Initialize
        arst = 1;
        baud_sel = 2'b00;  // 9600 baud
        tx_data_in = 8'hA5; // test byte
        start_tx = 0;
        rx_line = 1;        // idle high

        #100;
        arst = 0;

        //----------------------------------
        // Transmit a byte via top module
        //----------------------------------
        #50;
        start_tx = 1;
        #10;
        start_tx = 0;

        //----------------------------------
        // Simulate receiving data on rx_line
        // Send 8'b10101010 (LSB first)
        //----------------------------------
        rx_line = 0; #10400; // start bit, wait ~1 bit time
        rx_line = 0; #10400; // bit0
        rx_line = 1; #10400; // bit1
        rx_line = 0; #10400; // bit2
        rx_line = 1; #10400; // bit3
        rx_line = 0; #10400; // bit4
        rx_line = 1; #10400; // bit5
        rx_line = 0; #10400; // bit6
        rx_line = 1; #10400; // bit7
        rx_line = 1; #10400; // stop bit

        //----------------------------------
        // Change baud rate and transmit another byte
        //----------------------------------
        #50000;
        baud_sel = 2'b01;  // 19200 baud
        tx_data_in = 8'h3C;
        start_tx = 1;
        #10;
        start_tx = 0;

        //----------------------------------
        // Wait and finish simulation
        //----------------------------------
        #100000;
        $stop;
    end

    //----------------------------------
    // Monitor signals
    //----------------------------------
    initial begin
        $monitor("TIME=%0t | tx_line=%b | rx_line=%b | rx_data=%h | rx_done=%b | tx_busy=%b",
                 $time, tx_line, rx_line, led, rx_done, tx_busy);
    end

endmodule