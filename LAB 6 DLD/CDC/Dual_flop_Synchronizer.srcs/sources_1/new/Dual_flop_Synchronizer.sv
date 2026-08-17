`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 09:45:25 PM
// Design Name: 
// Module Name: Dual_flop_Synchronizer
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


module Dual_flop_Synchronizer_TM(
    input  logic clk_100MHz,
    input  logic rst_n,
    output logic [7:0] count_a,
    output logic [7:0] count_b
);

    logic clk_a, clk_b;
    logic rst_a, rst_b;

    logic pulse_50;
    logic toggle_a, toggle_sync_b;

    // Clock generation
    Clk_Gen cg (
        .clk_100MHz(clk_100MHz),
        .rst_n(rst_n),
        .clk_a(clk_a),
        .clk_b(clk_b)
    );

    // Reset synchronization
    Rst_Synchronizer r1 (.clk(clk_a), .rst_n(rst_n), .rst(rst_a));
    Rst_Synchronizer r2 (.clk(clk_b), .rst_n(rst_n), .rst(rst_b));

    // Pulse + toggle generator
    Toggle_Gen ptg (
        .clk_a(clk_a),
        .rst(rst_a),
        .pulse_50(pulse_50),
        .toggle_out(toggle_a),
        .count_a(count_a)
    );

    // CDC synchronizer
    Toggle_Synchronizer ts (
        .clk_b(clk_b),
        .rst(rst_b),
        .toggle_in(toggle_a),
        .toggle_sync(toggle_sync_b)
    );

    // Counter in clk_b domain
    Counter_30MHZ cb (
        .clk_b(clk_b),
        .rst(rst_b),
        .toggle_sync(toggle_sync_b),
        .count_b(count_b)
    );

endmodule
