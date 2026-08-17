`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2026 10:58:02 PM
// Design Name: 
// Module Name: LIFO_Buffer_tb
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

module LIFO_Buffer_tb;

    parameter WIDTH = 32;
    parameter DEPTH = 8;

    // DUT signals
    logic clk;
    logic rst;
    logic en;
    logic rw;
    logic [WIDTH-1:0] data_in;
    logic [WIDTH-1:0] data_out;
    logic full;
    logic empty;

    // Instantiate DUT
    LIFO_Buffer #(WIDTH, DEPTH) dut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .rw(rw),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    // -----------------------------
    // 100 MHz Clock ? 10ns period
    // -----------------------------
    always #5 clk = ~clk;

    // -----------------------------
    // Test Sequence
    // -----------------------------
    initial begin
        clk = 0;
        rst = 1;
        en  = 0;
        rw  = 0;
        data_in = 0;

        // Reset
        #10 rst = 0;

        // -------------------------
        // PUSH Operations
        // -------------------------
        en = 1;
        rw = 1;

        data_in = 32'hA1; #10;
        data_in = 32'hB2; #10;
        data_in = 32'hC3; #10;
        data_in = 32'hD4; #10;

        // -------------------------
        // POP Operations
        // -------------------------
        rw = 0;

        #10;  // should output D4
        #10;  // C3
        #10;  // B2
        #10;  // A1

        // -------------------------
        // Underflow Check
        // -------------------------
        #10;

        // -------------------------
        // Fill Completely (FULL)
        // -------------------------
        rw = 1;
        data_in = 32'h11; #10;
        data_in = 32'h22; #10;
        data_in = 32'h33; #10;
        data_in = 32'h44; #10;
        data_in = 32'h55; #10;
        data_in = 32'h66; #10;
        data_in = 32'h77; #10;
        data_in = 32'h88; #10;

        // Try overflow
        data_in = 32'h99; #10;

        #20 $finish;
    end

endmodule
