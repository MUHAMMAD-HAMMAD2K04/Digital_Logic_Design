`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2026 04:05:33 AM
// Design Name: 
// Module Name: ASYNC_FIFO
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


module ASYNC_FIFO #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 3   // depth = 2^3 = 8
)(
    input  logic wr_clk, rd_clk,
    input  logic rst_n,
    input  logic wr_en,
    input  logic rd_en,
    input  logic [DATA_WIDTH-1:0] wdata,
    output logic [DATA_WIDTH-1:0] rdata,
    output logic full,
    output logic empty
);

    localparam DEPTH = 1 << ADDR_WIDTH;

    // Memory
    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // Binary pointers
    logic [ADDR_WIDTH:0] wr_ptr_bin, rd_ptr_bin;

    // Gray pointers
    logic [ADDR_WIDTH:0] wr_ptr_gray, rd_ptr_gray;

    // Synced pointers
    logic [ADDR_WIDTH:0] wr_ptr_gray_sync, rd_ptr_gray_sync;

    // Binary -> Gray conversion
    function automatic [ADDR_WIDTH:0] bin2gray(input [ADDR_WIDTH:0] bin);
        return (bin >> 1) ^ bin;
    endfunction

    // -------------------------
    // WRITE DOMAIN
    // -------------------------
    always_ff @(posedge wr_clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr_bin  <= 0;
            wr_ptr_gray <= 0;
        end else if (wr_en && !full) begin
            mem[wr_ptr_bin[ADDR_WIDTH-1:0]] <= wdata;
            wr_ptr_bin  <= wr_ptr_bin + 1;
            wr_ptr_gray <= bin2gray(wr_ptr_bin + 1);
        end
    end

    // -------------------------
    // READ DOMAIN
    // -------------------------
    always_ff @(posedge rd_clk or negedge rst_n) begin
        if (!rst_n) begin
            rd_ptr_bin  <= 0;
            rd_ptr_gray <= 0;
            rdata       <= 0;
        end else if (rd_en && !empty) begin
            rdata       <= mem[rd_ptr_bin[ADDR_WIDTH-1:0]];
            rd_ptr_bin  <= rd_ptr_bin + 1;
            rd_ptr_gray <= bin2gray(rd_ptr_bin + 1);
        end
    end

    // -------------------------
    // Pointer Synchronization
    // -------------------------
    SYNC_CKT #(ADDR_WIDTH+1) sync_wr2rd (
        .clk(rd_clk),
        .rst_n(rst_n),
        .d(wr_ptr_gray),
        .q(wr_ptr_gray_sync)
    );

    SYNC_CKT #(ADDR_WIDTH+1) sync_rd2wr (
        .clk(wr_clk),
        .rst_n(rst_n),
        .d(rd_ptr_gray),
        .q(rd_ptr_gray_sync)
    );

    // -------------------------
    // FULL & EMPTY Flags
    // -------------------------
    assign full  = (wr_ptr_gray == {~rd_ptr_gray_sync[ADDR_WIDTH:ADDR_WIDTH-1],
                                   rd_ptr_gray_sync[ADDR_WIDTH-2:0]});
    assign empty = (rd_ptr_gray == wr_ptr_gray_sync);

endmodule