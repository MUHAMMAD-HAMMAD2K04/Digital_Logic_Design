`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2026 07:50:19 PM
// Design Name: 
// Module Name: Mux_4x1_gate_level
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

module Mux_2x1_gate_level(
output logic y, 
input logic s, 
input logic a, 
input logic b
); //Port Declaration

        logic and1,and2,not1;
        //Mux_2x1 using gates
        not m0(not1,s);
        and n0(and1, not1, a);
        and n1(and2, s, b);
        or  n2(y, and1, and2);
        
        endmodule
        
    module Mux_4x1_gate_level(
                   output logic m, 
                   input logic s0, 
                   input logic s1, 
                   input logic u, 
                   input logic v, 
                   input logic w, 
                   input logic x
                   ); //Ports Declaration
        
        logic w0,w1;
        //level one 
        Mux_2x1_gate_level mux1(w0 , s0, u, v);  //Sel[0] 
        Mux_2x1_gate_level mux2(w1 , s0, w, x);  //Sel[0]
        // final combination 
        Mux_2x1_gate_level mux3(m , s1, w0, w1); //Sel[1]
        
    
endmodule

