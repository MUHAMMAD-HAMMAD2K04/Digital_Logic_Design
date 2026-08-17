`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 11:32:37 PM
// Design Name: 
// Module Name: Source_Domain
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

module Source_Domain(
    input  logic clk_a,
    input  logic rst,
    input  logic ack_sync,
    output logic valid,
    output logic [7:0] data_out,
    output logic [7:0] count_a
);

    logic transfer_done;

    always_ff @(posedge clk_a) begin
        if (rst) begin
            valid          <= 0;
            data_out       <= 0;
            count_a        <= 0;
            transfer_done  <= 0;
        end else begin

            // SEND DATA
            if (!valid && !ack_sync && !transfer_done) begin
                data_out <= count_a;
                valid    <= 1;
            end

            // ACK RECEIVED
            else if (valid && ack_sync) begin
                valid <= 0;
                transfer_done <= 1;
            end

            // ACK CLEARED ? increment
            else if (!valid && !ack_sync && transfer_done) begin
                count_a <= count_a + 1;
                transfer_done <= 0;
            end

        end
    end

endmodule
