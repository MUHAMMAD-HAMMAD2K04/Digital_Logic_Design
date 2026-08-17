`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 09:58:03 PM
// Design Name: 
// Module Name: Toggle_Synchronizer
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


module Toggle_Synchronizer(
    input  logic clk_b,
    input  logic rst,
    input  logic toggle_in,
    output logic toggle_sync
);

    logic ff1, ff2;

    always_ff @(posedge clk_b) begin
        if (rst) begin
            ff1 <= 0;
            ff2 <= 0;
        end else begin
            ff1 <= toggle_in;
            ff2 <= ff1;
        end
    end

    assign toggle_sync = ff2;

endmodule
