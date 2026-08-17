`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2026 11:18:22 PM
// Design Name: 
// Module Name: Dual_Mem_Port
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: True Dual-Port Memory with Flow-Through and Pipeline Modes
// 
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// - ce0 active LOW, ce1 active HIGH
// - oe active LOW
// - rw: 1=READ, 0=WRITE
// - mode: 0=Flow-Through (1 cycle latency), 1=Pipeline (2 cycle latency)
//////////////////////////////////////////////////////////////////////////////////

module Dual_Mem_Port #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
)(
    // LEFT PORT
    input  logic                    clk_l,
    input  logic                    rst_l,
    input  logic                    ce0_l,
    input  logic                    ce1_l,
    input  logic                    rw_l,
    input  logic                    oe_l,
    input  logic                    mode_l,
    input  logic [ADDR_WIDTH-1:0]   addr_l,
    inout  wire  [DATA_WIDTH-1:0]   data_l,
    
    // RIGHT PORT
    input  logic                    clk_r,
    input  logic                    rst_r,
    input  logic                    ce0_r,
    input  logic                    ce1_r,
    input  logic                    rw_r,
    input  logic                    oe_r,
    input  logic                    mode_r,
    input  logic [ADDR_WIDTH-1:0]   addr_r,
    inout  wire  [DATA_WIDTH-1:0]   data_r
);

    // ========================================================================
    // PARAMETERS
    // ========================================================================
    localparam DEPTH = 1 << ADDR_WIDTH;

    // ========================================================================
    // MEMORY ARRAY
    // ========================================================================
    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // ========================================================================
    // LEFT PORT SIGNALS
    // ========================================================================
    logic [DATA_WIDTH-1:0] rd_data_l_s1;
    logic [DATA_WIDTH-1:0] rd_data_l_s2;
    logic [DATA_WIDTH-1:0] dout_l;
    
    // ========================================================================
    // RIGHT PORT SIGNALS
    // ========================================================================
    logic [DATA_WIDTH-1:0] rd_data_r_s1;
    logic [DATA_WIDTH-1:0] rd_data_r_s2;
    logic [DATA_WIDTH-1:0] dout_r;

    // ========================================================================
    // ENABLE LOGIC
    // ========================================================================
    wire enable_l = !ce0_l && ce1_l;
    wire enable_r = !ce0_r && ce1_r;

    // ========================================================================
    // MEMORY INITIALIZATION
    // ========================================================================
    initial begin
        for (int i = 0; i < DEPTH; i++) begin
            mem[i] = 8'h22;
        end
    end

    // ========================================================================
    // TRI-STATE OUTPUTS
    // ========================================================================
    assign data_l = (!oe_l && enable_l && rw_l) ? dout_l : {DATA_WIDTH{1'bz}};
    assign data_r = (!oe_r && enable_r && rw_r) ? dout_r : {DATA_WIDTH{1'bz}};

    // ========================================================================
    // LEFT PORT LOGIC
    // ========================================================================
    always_ff @(posedge clk_l) begin
        if (rst_l) begin
            rd_data_l_s1 <= '0;
            rd_data_l_s2 <= '0;
        end
        else if (enable_l) begin
            // Write operation (synchronous write)
            if (!rw_l) begin
                mem[addr_l] <= data_l;
            end
            
            // Read operation (synchronous read)
            // Stage 1: Read from memory on current cycle
            rd_data_l_s1 <= mem[addr_l];
            
            // Stage 2: Pipeline register
            rd_data_l_s2 <= rd_data_l_s1;
        end
    end

    // Left port output mux
    assign dout_l = mode_l ? rd_data_l_s2 : rd_data_l_s1;

    // ========================================================================
    // RIGHT PORT LOGIC
    // ========================================================================
    always_ff @(posedge clk_r) begin
        if (rst_r) begin
            rd_data_r_s1 <= '0;
            rd_data_r_s2 <= '0;
        end
        else if (enable_r) begin
            // Write operation (synchronous write)
            if (!rw_r) begin
                mem[addr_r] <= data_r;
            end
            
            // Read operation (synchronous read)
            // Stage 1: Read from memory on current cycle
            rd_data_r_s1 <= mem[addr_r];
            
            // Stage 2: Pipeline register
            rd_data_r_s2 <= rd_data_r_s1;
        end
    end

    // Right port output mux
    assign dout_r = mode_r ? rd_data_r_s2 : rd_data_r_s1;

endmodule