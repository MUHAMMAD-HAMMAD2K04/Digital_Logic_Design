`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2026 09:07:29 PM
// Design Name: 
// Module Name: Barrel_Shifter_tb
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


module Barrel_Shifter_tb();

logic [3:0] y;
logic [3:0] w;
logic [1:0] s;
logic [1:0] Sel_mode;


// Instantiating Top Module
Barrel_Shifter DUT(.*);

initial
begin

//Selecting Left_Barrel Shifter
Sel_mode = 2'b00;

w = 4'b1001; s = 2'b00; #10;
w = 4'b1001; s = 2'b01; #10;
w = 4'b1001; s = 2'b10; #10;
w = 4'b1001; s = 2'b11; #10;

//Selecting Right_Barrel Shifter
Sel_mode = 2'b01;

w = 4'b1001; s = 2'b00; #10;
w = 4'b1001; s = 2'b01; #10;
w = 4'b1001; s = 2'b10; #10;
w = 4'b1001; s = 2'b11; #10;

//Selecting Right_Round_Barrel Shifter
Sel_mode = 2'b10;

w = 4'b1001; s = 2'b00; #10;
w = 4'b1001; s = 2'b01; #10;
w = 4'b1001; s = 2'b10; #10;
w = 4'b1001; s = 2'b11; #10;

$finish;

end

initial
begin
$monitor("Time = %d, Sel_mode = %b, y[0] = %b, y[1] = %b, y[2] = %b, y[3] = %b, w[0] = %b, w[1] = %b, w[2] = %b, w[3] = %b, s[0] = %b, s[1] = %b",$time, Sel_mode, y[0], y[1], y[2], y[3], w[0], w[1], w[2], w[3], s[0], s[1]); 
end

endmodule
