`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 10:00:08 PM
// Design Name: 
// Module Name: Counter_30MHZ
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


module Counter_30MHZ(
    input  logic clk_b,
    input  logic rst,
    input  logic toggle_sync,
    output logic [7:0] count_b
);

    logic prev;

    always_ff @(posedge clk_b) begin
        if (rst) begin
            prev    <= 0;
            count_b <= 0;
        end else begin
            if (toggle_sync ^ prev)
                count_b <= count_b + 1;

            prev <= toggle_sync;
        end
    end

endmodule