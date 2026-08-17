`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2026 06:34:58 PM
// Design Name: 
// Module Name: Mux_4x1_gate_level_tb
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


module Mux_4x1_gate_level_tb();
// Inputs & Outputs
logic m; 
logic s0; 
logic s1; 
logic u; 
logic v; 
logic w; 
logic x;


//Instantiating DUT for Mux_4x1
Mux_4x1_gate_level DUT(.m(m),.s0(s0),.s1(s1),.u(u),.v(v),.w(w),.x(x));

// Testing Different Test Cases
initial
begin

u = 1'b0; v = 1'b0; w = 1'b0; x = 1'b0; s0 = 1'b0; s1 = 1'b0; #10;
$display("u = %b,v = %b,w = %b,x = %b, s0 = %b, s1 = %b, m = %b", u, v, w, x, s0, s1, m);

u = 1'b0; v = 1'b0; w = 1'b0; x = 1'b1; s0 = 1'b0; s1 = 1'b1; #10;
$display("u = %b,v = %b,w = %b,x = %b, s0 = %b, s1 = %b, m = %b", u, v, w, x, s0, s1, m);

u = 1'b0; v = 1'b0; w = 1'b0; x = 1'b0; s0 = 1'b1; s1 = 1'b0; #10;
$display("u = %b,v = %b,w = %b,x = %b, s0 = %b, s1 = %b, m = %b", u, v, w, x, s0, s1, m);

u = 1'b1; v = 1'b0; w = 1'b1; x = 1'b1; s0 = 1'b1; s1 = 1'b1; #10;
$display("u = %b,v = %b,w = %b,x = %b, s0 = %b, s1 = %b, m = %b", u, v, w, x, s0, s1, m);

u = 1'b0; v = 1'b0; w = 1'b1; x = 1'b0; s0 = 1'b1; s1 = 1'b0; #10;
$display("u = %b,v = %b,w = %b,x = %b, s0 = %b, s1 = %b, m = %b", u, v, w, x, s0, s1, m);

u = 1'b1; v = 1'b1; w = 1'b0; x = 1'b1; s0 = 1'b0; s1 = 1'b0; #10;
$display("u = %b,v = %b,w = %b,x = %b, s0 = %b, s1 = %b, m = %b", u, v, w, x, s0, s1, m); 

u = 1'b0; v = 1'b1; w = 1'b1; x = 1'b0; s0 = 1'b0; s1 = 1'b1; #10;
$display("u = %b,v = %b,w = %b,x = %b, s0 = %b, s1 = %b, m = %b", u, v, w, x, s0, s1, m);

$stop;

end
endmodule
