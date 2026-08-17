`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2026 09:24:42 PM
// Design Name: 
// Module Name: LIFO_Buffer
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


module LIFO_Buffer #(parameter WIDTH = 8, parameter DEPTH = 8)(
    input  logic clk,
    input  logic rst,
    input  logic en,
    input  logic rw,   // 1 = PUSH, 0 = POP
    input  logic [WIDTH-1:0] data_in,
    output logic full,
    output logic empty,
    output logic [WIDTH-1:0] data_out);

    // -----------------------------
    // Stack Pointer (FIXED)
    // -----------------------------
    logic [$clog2(DEPTH):0] sp;

    // -----------------------------
    // Memory (FIXED WIDTH)
    // -----------------------------
    logic [WIDTH-1:0] memory [0:DEPTH-1];

    // -----------------------------
    // Synchronous PUSH / POP
    // -----------------------------
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            sp <= 0;
        end
        else if (en) begin

            // PUSH
            if (rw && !full) begin
                memory[sp] <= data_in;
                sp <= sp + 1;
            end

            // POP
            else if (!rw && !empty) begin
                sp <= sp - 1;
            end

        end
    end

    // -----------------------------
    // Asynchronous READ (IMPORTANT)
    // -----------------------------
    assign data_out = (!empty) ? memory[sp-1] : '0;

    // -----------------------------
    // FULL / EMPTY FLAGS
    // -----------------------------
    assign full  = (sp == DEPTH);
    assign empty = (sp == 0);

endmodule