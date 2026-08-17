`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2026 04:12:51 AM
// Design Name: 
// Module Name: ASYNC_FIFO_TM
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


module ASYNC_FIFO_TM(
    input  logic clk_100MHz, // 100 MHz global clock
    input  logic rst_n,       // Asynchronous active-low reset
    output logic [7:0] data_out
);

    // -------------------------
    // Internal Signals
    // -------------------------
    logic clk_a, clk_b;            // Generated clocks (25 MHz / ~33 MHz)
    logic rst_a_sync, rst_b_sync;  // Synchronized resets
    logic [7:0] counter;
    logic full, empty;
    logic wr_en, rd_en;
    logic [7:0] rdata;

    // -------------------------
    // Clock Generation
    // -------------------------
    CLK_GEN clkgen_inst (
        .clk_100MHz(clk_100MHz),
        .rst_n(rst_n),
        .clk_a(clk_a),
        .clk_b(clk_b)
    );

    // -------------------------
    // Reset Synchronizers
    // -------------------------
    RST_SYNC rst_a_inst (
        .clk(clk_a),
        .rst_n(rst_n),
        .rst(rst_a_sync)
    );

    RST_SYNC rst_b_inst (
        .clk(clk_b),
        .rst_n(rst_n),
        .rst(rst_b_sync)
    );

    // -------------------------
    // Write / Read Enables
    // -------------------------
    assign wr_en = !full;
    assign rd_en = !empty;

    // -------------------------
    // Counter for FIFO write data
    // -------------------------
    always_ff @(posedge clk_a or posedge rst_a_sync) begin
        if (rst_a_sync)
            counter <= 0;
        else if (wr_en)
            counter <= counter + 1;
    end

    // -------------------------
    // Async FIFO Instance
    // -------------------------
    ASYNC_FIFO fifo_inst (
        .wr_clk(clk_a),
        .rd_clk(clk_b),
        .rst_n(rst_n),  // FIFO internal reset can still use async reset
        .wr_en(wr_en),
        .rd_en(rd_en),
        .wdata(counter),
        .rdata(rdata),
        .full(full),
        .empty(empty)
    );

    assign data_out = rdata;

endmodule