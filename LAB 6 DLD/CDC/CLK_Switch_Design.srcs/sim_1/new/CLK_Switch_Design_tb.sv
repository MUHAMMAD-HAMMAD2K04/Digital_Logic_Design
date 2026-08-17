`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2026 06:41:32 AM
// Design Name: 
// Module Name: CLK_Switch_Design_tb
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


module CLK_Switch_Design_tb;
   
    // -------------------------
    // Signals
    // -------------------------
   
    logic clk = 0;
    logic rst_n;
    logic clk_sel;
    logic clk_out;

 initial clk = 0;
 always #5 clk = ~ clk;
 
    // -------------------------
    // DUT Instantiation
    // -------------------------
    CLK_Switch_Design_TM dut (
        .clk(clk),
        .rst_n(rst_n),
        .clk_sel(clk_sel),
        .clk_out(clk_out)
    );

    // -------------------------
    // Monitor
    // -------------------------
    initial begin
        $display("\nTime\tclk_sel\tclk_out");
        $monitor("%0t\t%b\t%b", $time, clk_sel, clk_out);
    end

    // -------------------------
    // Stimulus
    // -------------------------
    initial begin
        // Apply async reset
        rst_n = 0;
        clk_sel = 0;
        #50;                  // hold reset for 50 ns

        // Release reset
        rst_n = 1;

        // Wait a bit for reset to propagate
        #50;

        // Test clock switching
        clk_sel = 1;           // switch to clk1
        #200;                  
        clk_sel = 0;           // back to clk0
        #200;                  
        clk_sel = 1;           // switch to clk1
        #200;                  
        clk_sel = 0;           // back to clk0
        #200;

        $display("\n--- Simulation Finished ---\n");
        $finish;
    end

endmodule