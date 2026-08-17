`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2026 03:37:54 PM
// Design Name: 
// Module Name: ASYN_FIFO_TB
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


module ASYN_FIFO_TB;

    parameter WIDTH = 8;
    parameter DEPTH = 16;

    // Signals
    logic write_clk, read_clk;
    logic write_reset_n, read_reset_n;
    logic write_enable, read_enable;
    logic [WIDTH-1:0] write_data;
    logic [WIDTH-1:0] read_data;
    logic fifo_full, fifo_empty, fifo_half_full;

    // Instantiate DUT
    ASNYC_FIFO #(WIDTH, DEPTH) dut (
        .write_clk(write_clk),
        .write_reset_n(write_reset_n),
        .write_enable(write_enable),
        .write_data(write_data),

        .read_clk(read_clk),
        .read_reset_n(read_reset_n),
        .read_enable(read_enable),
        .read_data(read_data),

        .fifo_full(fifo_full),
        .fifo_empty(fifo_empty),
        .fifo_half_full(fifo_half_full)
    );

    // ---------------- CLOCKS ----------------
    // Write clock = 100 MHz ? 10ns
    always #5 write_clk = ~write_clk;

    // Read clock = slower ? 20ns
    always #10 read_clk = ~read_clk;

    // ---------------- TEST ----------------
    initial begin
        // Initialize
        write_clk = 0;
        read_clk  = 0;
        write_reset_n = 0;
        read_reset_n  = 0;
        write_enable  = 0;
        read_enable   = 0;
        write_data    = 0;

        // Reset
        #20;
        write_reset_n = 1;
        read_reset_n  = 1;

        // ---------------- WRITE DATA ----------------
        $display("---- Writing Data ----");
        write_enable = 1;

        for (int i = 0; i < DEPTH; i++) begin
            write_data = i;
            #10;
        end

        // Try overflow
        $display("---- Overflow Test ----");
        write_data = 8'hFF;
        #10;

        write_enable = 0;

        // ---------------- READ DATA ----------------
        $display("---- Reading Data ----");
        read_enable = 1;

        for (int i = 0; i < DEPTH; i++) begin
            #20;
        end

        // Try underflow
        $display("---- Underflow Test ----");
        #20;

        read_enable = 0;

        // ---------------- HALF FULL TEST ----------------
        $display("---- Half Full Test ----");
        write_enable = 1;

        for (int i = 0; i < DEPTH/2; i++) begin
            write_data = i + 10;
            #10;
        end

        write_enable = 0;

        #50;
        $finish;
    end

endmodule
