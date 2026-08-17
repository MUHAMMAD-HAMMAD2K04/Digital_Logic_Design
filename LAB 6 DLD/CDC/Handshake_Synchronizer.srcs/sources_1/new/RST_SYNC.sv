`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2026 04:49:40 AM
// Design Name: 
// Module Name: RST_SYNC
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


module RST_SYNC(
    input  logic clk,
    input  logic rst_n,
    output logic rst
);

    logic [2:0] shift;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            shift <= 3'b111;
        else
            shift <= {shift[1:0], 1'b0};
    end

    assign rst = shift[2];

endmodule
