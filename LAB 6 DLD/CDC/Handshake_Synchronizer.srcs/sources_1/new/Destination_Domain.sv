`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 11:33:24 PM
// Design Name: 
// Module Name: Destination_Domain
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


module Destination_Domain(
    input  logic clk_b,
    input  logic rst,

    input  logic valid_sync,
    input  logic [7:0] data_in,

    output logic ack,
    output logic [7:0] data_received,
    output logic [7:0] count_b
);

    always_ff @(posedge clk_b) begin
        if (rst) begin
            ack           <= 0;
            data_received <= 0;
            count_b       <= 0;
        end else begin

            // RECEIVE DATA
            if (valid_sync && !ack) begin
                data_received <= data_in;
                count_b       <= count_b + 1;
                ack           <= 1;
            end

            // CLEAR ACK
            else if (!valid_sync && ack) begin
                ack <= 0;
            end

        end
    end

endmodule
