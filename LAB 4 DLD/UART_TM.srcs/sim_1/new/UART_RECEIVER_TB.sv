`timescale 1ns / 1ps

module UART_RECEIVER_tb;

    logic rx_data;
    logic bclkx8;
    logic arst;
    logic [7:0] d_out;
    logic rx_status;

    // DUT
    UART_RECEIVER dut(
        .rx_data(rx_data),
        .bclkx8(bclkx8),
        .arst(arst),
        .d_out(d_out),
        .rx_status(rx_status)
    );

    //----------------------------------
    // Clock
    //----------------------------------
    initial begin
        bclkx8 = 0;
        forever #5 bclkx8 = ~bclkx8; // 100 MHz
    end

    //----------------------------------
    // Stimulus
    //----------------------------------
    initial begin

        arst = 1;
        rx_data = 1; // idle
        #30;
        arst = 0;

        //----------------------------------
        // BYTE 1: 10101010
        //----------------------------------
        rx_data = 0; #80; // start bit
        rx_data = 0; #80; // bit0
        rx_data = 1; #80; // bit1
        rx_data = 0; #80; // bit2
        rx_data = 1; #80; // bit3
        rx_data = 0; #80; // bit4
        rx_data = 1; #80; // bit5
        rx_data = 0; #80; // bit6
        rx_data = 1; #80; // bit7
        rx_data = 1; #80; // stop bit

        #100;

        //----------------------------------
        // BYTE 2: 11001100
        //----------------------------------
        rx_data = 0; #80; // start bit
        rx_data = 0; #80; // bit0
        rx_data = 0; #80; // bit1
        rx_data = 1; #80; // bit2
        rx_data = 1; #80; // bit3
        rx_data = 0; #80; // bit4
        rx_data = 0; #80; // bit5
        rx_data = 1; #80; // bit6
        rx_data = 1; #80; // bit7
        rx_data = 1; #80; // stop bit

        #100;

        //----------------------------------
        // BYTE 3: 11110000
        //----------------------------------
        rx_data = 0; #80; // start bit
        rx_data = 0; #80; // bit0
        rx_data = 0; #80; // bit1
        rx_data = 0; #80; // bit2
        rx_data = 0; #80; // bit3
        rx_data = 1; #80; // bit4
        rx_data = 1; #80; // bit5
        rx_data = 1; #80; // bit6
        rx_data = 1; #80; // bit7
        rx_data = 1; #80; // stop bit

        #100;

        //----------------------------------
        // BYTE 4: 01010101
        //----------------------------------
        rx_data = 0; #80; // start bit
        rx_data = 1; #80; // bit0
        rx_data = 0; #80; // bit1
        rx_data = 1; #80; // bit2
        rx_data = 0; #80; // bit3
        rx_data = 1; #80; // bit4
        rx_data = 0; #80; // bit5
        rx_data = 1; #80; // bit6
        rx_data = 0; #80; // bit7
        rx_data = 1; #80; // stop bit

        #200;

        $finish;
    end

endmodule