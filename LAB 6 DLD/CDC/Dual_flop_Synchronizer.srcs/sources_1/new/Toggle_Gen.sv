`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 09:55:18 PM
// Design Name: 
// Module Name: Toggle_Gen
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


module Toggle_Gen(

    input  logic clk_a,
    input  logic rst,
    output logic pulse_50,
    output logic toggle_out,
    output logic [7:0] count_a
);

    logic prev;

    always_ff @(posedge clk_a) begin
        if (rst) begin
            pulse_50   <= 0;
            toggle_out <= 0;
            prev       <= 0;
            count_a    <= 0;
        end else begin
            pulse_50 <= ~pulse_50;  // 50% duty cycle

            // Rising edge detection
            if (pulse_50 && !prev) begin
                toggle_out <= ~toggle_out;
                count_a    <= count_a + 1;
            end

            prev <= pulse_50;
        end
    end

endmodule
