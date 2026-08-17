`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2026 08:51:44 AM
// Design Name: 
// Module Name: Frequency_Divider_tb
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


module Frequency_Divider_tb();

logic clk,rst;
logic Y;
//ports


// Instanciating DUT
Frequency_Divider DUT(.*);

initial clk = 0;       //initialize clock
always #5 clk = ~clk;  // Generate a clock cycle of 10ns


initial 
begin

rst = 1'b1;
#15
rst = 1'b0;

#200 $finish;

end

initial
$monitor("Time=%0t Y=%b",$time,Y);

endmodule
