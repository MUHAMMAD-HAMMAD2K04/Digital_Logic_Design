`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 11:34:12 PM
// Design Name: 
// Module Name: Dual_Flop_Synchronizer
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


module Dual_Flop_Synchronizer(
    input  logic clk,
    input  logic rst,
    input  logic d,
    output logic q
);

    logic ff1, ff2;

    always_ff @(posedge clk) begin
        if (rst) begin
            ff1 <= 0;
            ff2 <= 0;
        end else begin
            ff1 <= d;
            ff2 <= ff1;
        end
    end

    assign q = ff2;

endmodule