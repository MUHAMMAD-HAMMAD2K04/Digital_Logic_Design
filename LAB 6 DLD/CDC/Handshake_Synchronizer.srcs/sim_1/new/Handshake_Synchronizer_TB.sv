`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 11:41:38 PM
// Design Name: 
// Module Name: Handshake_Synchronizer_TB
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


module Handshake_Synchronizer_TB;

    // =========================
    // Signals
    // =========================
    logic clk = 0;
    logic rst_n;
    logic [7:0] count_a;
    logic [7:0] count_b;

    // =========================
    // 100 MHz Clock Generation
    // =========================
    always #5 clk = ~clk;   // 10 ns period

    // =========================
    // DUT Instantiation
    // =========================
    Handshake_Synchronizer dut (
        .clk(clk),
        .rst_n(rst_n),
        .count_a(count_a),
        .count_b(count_b)
    );

    // =========================
    // Monitor (continuous print)
    // =========================
    initial begin
        $monitor("Time=%0t | count_a=%0d | count_b=%0d",
                  $time, count_a, count_b);
    end

    // =========================
    // Stimulus
    // =========================
    initial begin
        // Apply reset
        rst_n = 0;
        #50;

        // Release reset
        rst_n = 1;

        $display("\n--- Simulation Started ---\n");

        // Run simulation
        #5000;

        // Final results
        $display("\n--- Final Values ---");
        $display("Count A = %0d", count_a);
        $display("Count B = %0d", count_b);

        if (count_a == count_b)
            $display("PASS ? Handshake Working Correctly");
        else
            $display("FAIL ? Mismatch Detected");

        $display("\n--- Simulation Finished ---\n");

        $finish;
    end

endmodule