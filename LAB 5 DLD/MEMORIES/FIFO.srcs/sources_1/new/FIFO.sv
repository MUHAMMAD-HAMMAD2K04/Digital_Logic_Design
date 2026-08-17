`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2026 03:26:10 PM
// Design Name: 
// Module Name: FIFO
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


module ASNYC_FIFO #(
    parameter WIDTH = 8,
    parameter DEPTH = 16
)(
    // Write side
    input  logic write_clk,
    input  logic write_reset_n,
    input  logic write_enable,
    input  logic [WIDTH-1:0] write_data,

    // Read side
    input  logic read_clk,
    input  logic read_reset_n,
    input  logic read_enable,
    output logic [WIDTH-1:0] read_data,

    // Status
    output logic fifo_full,
    output logic fifo_empty,
    output logic fifo_half_full
);

    localparam ADDR_WIDTH = $clog2(DEPTH);

    // Memory
    logic [WIDTH-1:0] memory [0:DEPTH-1];

    // Binary pointers
    logic [ADDR_WIDTH:0] write_pointer_bin;
    logic [ADDR_WIDTH:0] read_pointer_bin;

    // Gray pointers
    logic [ADDR_WIDTH:0] write_pointer_gray;
    logic [ADDR_WIDTH:0] read_pointer_gray;

    // Synchronization registers
    logic [ADDR_WIDTH:0] sync_read_gray_1, sync_read_gray_2;
    logic [ADDR_WIDTH:0] sync_write_gray_1, sync_write_gray_2;

    // ---------------- WRITE DOMAIN ----------------
    always_ff @(posedge write_clk or negedge write_reset_n) begin
        if (!write_reset_n)
            write_pointer_bin <= 0;
        else if (write_enable && !fifo_full)
            write_pointer_bin <= write_pointer_bin + 1;
    end

    assign write_pointer_gray = write_pointer_bin ^ (write_pointer_bin >> 1);

    // Sync read pointer into write clock domain
    always_ff @(posedge write_clk or negedge write_reset_n) begin
        if (!write_reset_n) begin
            sync_read_gray_1 <= 0;
            sync_read_gray_2 <= 0;
        end else begin
            sync_read_gray_1 <= read_pointer_gray;
            sync_read_gray_2 <= sync_read_gray_1;
        end
    end

    // Full condition
    assign fifo_full = (write_pointer_gray ==
                       {~sync_read_gray_2[ADDR_WIDTH:ADDR_WIDTH-1],
                         sync_read_gray_2[ADDR_WIDTH-2:0]});

    // Write data
    always_ff @(posedge write_clk) begin
        if (write_enable && !fifo_full)
            memory[write_pointer_bin[ADDR_WIDTH-1:0]] <= write_data;
    end

    // ---------------- READ DOMAIN ----------------
    always_ff @(posedge read_clk or negedge read_reset_n) begin
        if (!read_reset_n)
            read_pointer_bin <= 0;
        else if (read_enable && !fifo_empty)
            read_pointer_bin <= read_pointer_bin + 1;
    end

    assign read_pointer_gray = read_pointer_bin ^ (read_pointer_bin >> 1);

    // Sync write pointer into read clock domain
    always_ff @(posedge read_clk or negedge read_reset_n) begin
        if (!read_reset_n) begin
            sync_write_gray_1 <= 0;
            sync_write_gray_2 <= 0;
        end else begin
            sync_write_gray_1 <= write_pointer_gray;
            sync_write_gray_2 <= sync_write_gray_1;
        end
    end

    // Empty condition
    assign fifo_empty = (read_pointer_gray == sync_write_gray_2);

    // Asynchronous read
    assign read_data = memory[read_pointer_bin[ADDR_WIDTH-1:0]];

    // ---------------- HALF FULL ----------------
    logic [ADDR_WIDTH:0] read_pointer_bin_sync;

    // Gray ? Binary conversion
    always_comb begin
        read_pointer_bin_sync[ADDR_WIDTH] = sync_read_gray_2[ADDR_WIDTH];
        for (int i = ADDR_WIDTH-1; i >= 0; i--)
            read_pointer_bin_sync[i] = read_pointer_bin_sync[i+1] ^ sync_read_gray_2[i];
    end

    assign fifo_half_full = ((write_pointer_bin - read_pointer_bin_sync) >= (DEPTH/2));

endmodule
