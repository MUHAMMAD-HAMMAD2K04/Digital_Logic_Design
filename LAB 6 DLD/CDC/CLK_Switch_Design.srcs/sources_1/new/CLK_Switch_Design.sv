`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2026 06:32:15 AM
// Design Name: 
// Module Name: CLK_Switch_Design
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


module CLK_Switch_Design_TM(
    input  logic clk,        // 100MHZ clk from FPGA
    input  logic rst_n,      // Async reset (active low)
    input  logic clk_sel,    // Async clock select
    output logic clk_out     // Output clock
);

    // -------------------------
    // Internal Signals
    // -------------------------
    logic clk0;       // Primary clock
    logic clk1;       // Secondary clock
    logic rst0, rst1;            // synchronized resets
    logic sel_sync0, sel_sync1;  // synchronized select signals

    CLK_GEN clk_gen(
    .clk_100MHz(clk),
    .rst_n(rst_n),
    .clk_a(clk0),   // 25 MHz
    .clk_b(clk1)    // ~33 MHz
);


    // -------------------------
    // Reset Synchronization
    // -------------------------
    RST_SYNC rst_sync0 (
        .clk(clk0),
        .rst_n(rst_n),
        .rst(rst0)
    );

    RST_SYNC rst_sync1 (
        .clk(clk1),
        .rst_n(rst_n),
        .rst(rst1)
    );

    // -------------------------
    // Synchronize clk_sel
    // -------------------------
    SYNC_CKT #(1) sync0 (
        .clk(clk0),
        .rst_n(~rst0),   // use synchronized reset
        .d(clk_sel),
        .q(sel_sync0)
    );

    SYNC_CKT #(1) sync1 (
        .clk(clk1),
        .rst_n(~rst1),   // use synchronized reset
        .d(clk_sel),
        .q(sel_sync1)
    );

    // -------------------------
    // Clock Switching Logic
    // -------------------------
    // Simple mux using synchronized select
    assign clk_out = (sel_sync0) ? clk1 : clk0;

endmodule
