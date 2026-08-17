`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2026 04:08:19 AM
// Design Name: 
// Module Name: ASYNC_FIFO_TM_TB
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

module ASYNC_FIFO_TM_TB;

    // =========================
    // Signals
    // =========================
    logic clk_100MHz = 0;
    logic rst_n;
    logic [7:0] data_out;

    // =========================
    // Clock Generation (100 MHz)
    // =========================
    always #5 clk_100MHz = ~clk_100MHz; // 100 MHz = 10 ns period

    // =========================
    // DUT Instantiation
    // =========================
    ASYNC_FIFO_TM dut (
        .clk_100MHz(clk_100MHz),
        .rst_n(rst_n),
        .data_out(data_out)
    );

    // =========================
    // Monitor FIFO output
    // =========================
    initial begin
        $display("\nTime\tData Out");
        $monitor("%0t\t%0d", $time, data_out);
    end

    // =========================
    // Stimulus
    // =========================
    initial begin
        // Apply asynchronous reset
        rst_n = 0;
        #50;              // hold reset for 50 ns

        // Release reset
        rst_n = 1;
        $display("\n--- Simulation Started ---\n");

        // Run simulation for 5 us (5000 ns)
        #5000;

        $display("\n--- Simulation Finished ---\n");
        $finish;
    end

endmodule
