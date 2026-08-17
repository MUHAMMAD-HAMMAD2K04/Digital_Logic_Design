`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2026 11:36:52 AM
// Design Name: 
// Module Name: Clock_Divider_75k_tb
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


module Clock_Divider_75k_tb();

logic clk;     // 100 MHz
logic rst;
logic clk_out;  // ~75 kHz
//ports

Clock_Divider_75k DUT(clk,rst,clk_out); //Instantiating Top Module

// Generate 100 MHz clock
// Period = 10 ns
initial clk = 0;
always #5 clk = ~clk;

// Stimulus
initial
begin
    rst = 1;
    #20;
    rst = 0;

    #1000000000;   // run long enough
    #1000000000;
    #1000000000;
    #1000000000;   
    $finish;
end

// Monitor signals
initial
begin
    $monitor("time=%0t counter=%d clk_out=%b",$time,DUT.counter,clk_out);
end

















endmodule
