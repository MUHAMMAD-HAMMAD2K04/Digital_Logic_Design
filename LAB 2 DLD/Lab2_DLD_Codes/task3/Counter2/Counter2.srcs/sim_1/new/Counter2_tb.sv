`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2026 09:34:42 PM
// Design Name: 
// Module Name: Counter2_tb
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


module Counter2_tb();

    // testbench signals
    logic clk;
    logic rst_n;
    logic [6:0] seg;
    logic [7:0] an;

    // instantiate design under test with simulation mode enabled
    top_sequence_7seg #(.SIM(1)) U_DUT (
        .clk(clk),
        .rst_n(rst_n),
        .seg(seg),
        .an(an)
    );

    // clock generation with 20 ns period
    initial clk = 0;
    always #10 clk = ~clk;

    // stimulus process
    initial begin

        // apply reset
        rst_n = 0;
        #50;

        // release reset to start counter operation
        rst_n = 1;

        // allow simulation to run long enough to observe sequence
        #1000_000;

    end

endmodule

