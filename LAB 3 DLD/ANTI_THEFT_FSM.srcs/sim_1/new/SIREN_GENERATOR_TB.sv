`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2026 05:48:41 AM
// Design Name: 
// Module Name: SIREN_GENERATOR_TB
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

module SIREN_GENERATOR_TB;

    // Testbench signals
    logic clk;
    logic rst;
    logic Siren_Enable;
    logic Siren_Out;

    // Instantiate DUT
    SIREN_GENERATOR dut (
        .clk(clk),
        .rst(rst),
        .Siren_Enable(Siren_Enable),
        .Siren_Out(Siren_Out)
    );

//////////////////////////////////////////////////
// Clock Generation (100 MHz)
//////////////////////////////////////////////////

always #5 clk = ~clk;   // 10 ns period

//////////////////////////////////////////////////
// Stimulus
//////////////////////////////////////////////////

initial
begin
    clk = 0;
    rst = 1;
    Siren_Enable = 0;

    // Apply reset
    #20;
    rst = 0;

    // Enable siren
    #20;
    Siren_Enable = 1;

    // Run simulation
    #500000000;



    #100;
    $finish;
end

//////////////////////////////////////////////////
// Monitor Signals
//////////////////////////////////////////////////

initial
begin
    $display("Time\tEnable\tSiren_Out");
    $monitor("%0t\t%b\t%b",$time,Siren_Enable,Siren_Out);
end

endmodule