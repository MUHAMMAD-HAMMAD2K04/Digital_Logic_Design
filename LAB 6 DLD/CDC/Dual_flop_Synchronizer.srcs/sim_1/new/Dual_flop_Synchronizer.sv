`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 10:05:28 PM
// Design Name: 
// Module Name: Dual_flop_Synchronizer_TB
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


module Dual_flop_Synchronizer_TB;

    logic clk_100MHz;
    logic rst_n;

    logic [7:0] count_a;
    logic [7:0] count_b;

    // Instantiate DUT
    Dual_flop_Synchronizer_TM dut (
        .clk_100MHz(clk_100MHz),
        .rst_n(rst_n),
        .count_a(count_a),
        .count_b(count_b)
    );

    // 100 MHz clock (10 ns period)
    initial clk_100MHz = 0;
    always #5 clk_100MHz = ~clk_100MHz;

    // Stimulus
    initial begin
        // Apply reset
        clk_100MHz = 0;
        rst_n = 0;
        #20;

        // Release reset
        rst_n = 1;

        // Run simulation
        #2000;

        // Display results
        $display("Count A = %0d", count_a);
        $display("Count B = %0d", count_b);

        $finish;
    end

endmodule
