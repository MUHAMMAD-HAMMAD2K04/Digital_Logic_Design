`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 09:47:32 PM
// Design Name: 
// Module Name: Clk_Gen
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


module Clk_Gen(
    input  logic clk_100MHz,
    input  logic rst_n,
    output logic clk_a,   // 25 MHz
    output logic clk_b    // ~33 MHz
);

    logic [1:0] cnt_a;
    logic [1:0] cnt_b;

    // 25 MHz (divide by 4)
    always_ff @(posedge clk_100MHz or negedge rst_n) begin
        if (!rst_n)
            cnt_a <= 0;
        else
            cnt_a <= cnt_a + 1;
    end

    assign clk_a = cnt_a[1];

    // ~33 MHz (divide by 3)
    always_ff @(posedge clk_100MHz or negedge rst_n) begin
        if (!rst_n)
            cnt_b <= 0;
        else if (cnt_b == 2)
            cnt_b <= 0;
        else
            cnt_b <= cnt_b + 1;
    end

    always_ff @(posedge clk_100MHz or negedge rst_n) begin
        if (!rst_n)
            clk_b <= 0;
        else if (cnt_b == 0)
            clk_b <= ~clk_b;
    end

endmodule
