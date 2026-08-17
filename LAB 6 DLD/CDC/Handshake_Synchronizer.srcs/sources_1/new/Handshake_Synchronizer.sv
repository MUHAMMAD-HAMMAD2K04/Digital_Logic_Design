`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 11:29:15 PM
// Design Name: 
// Module Name: Handshake_Synchronizer
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


module Handshake_Synchronizer(
    input  logic clk,
    input  logic rst_n,
    output logic [7:0] count_a,
    output logic [7:0] count_b
);

    logic valid, ack;
    logic valid_sync, ack_sync;

    logic [7:0] data_bus;
    logic [7:0] data_received;
    
    // =========================
    // Internal Signals
    // =========================
    logic clk_a, clk_b;
    logic rst_a, rst_b;
    logic rst;

    // =========================
    // 1. Clock Generator
    // =========================
    CLK_GEN u_clk_gen (
        .clk_100MHz(clk),
        .rst_n(rst_n),
        .clk_a(clk_a),
        .clk_b(clk_b)
    );

    // =========================
    // 2. Reset Synchronizers
    // =========================
    RST_SYNC u_rst_sync_a (
        .clk(clk_a),
        .rst_n(rst_n),
        .rst(rst_a)
    );

    RST_SYNC u_rst_sync_b (
        .clk(clk_b),
        .rst_n(rst_n),
        .rst(rst_b)
    );

    // Source
    Source_Domain src (
        .clk_a(clk_a),
        .rst(rst),
        .ack_sync(ack_sync),
        .valid(valid),
        .data_out(data_bus),
        .count_a(count_a)
    );

    // Destination
    Destination_Domain dst (
        .clk_b(clk_b),
        .rst(rst),
        .valid_sync(valid_sync),
        .data_in(data_bus),
        .ack(ack),
        .data_received(data_received),
        .count_b(count_b)
    );

    // Synchronizers
    Dual_Flop_Synchronizer sync_valid (.clk(clk_b), .rst(rst), .d(valid), .q(valid_sync));
    Dual_Flop_Synchronizer sync_ack   (.clk(clk_a), .rst(rst), .d(ack),   .q(ack_sync));

    assign rst = rst_a | rst_b;

endmodule
