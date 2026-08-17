`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2026 08:42:51 PM
// Design Name: 
// Module Name: Mux_4x1_Behavioral
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

    /*LAB TASK 1.2
    Create a System Verilog module to implement one -bit wide 4-to-1 multiplexer using
    Behavioral Modeling.*/

module Mux_4x1_Behavioral(
output logic y,
input logic [1:0] sel, 
input logic [3:0] in
    ); // Ports declarations

        always@(*) //Combinational Block
        begin
        
            if((sel[0]==1'b0) && (sel[1]==1'b0))      // sel = 00
            y = in[0]; 
            else if((sel[0]==1'b0) && (sel[1]==1'b1)) // sel = 01
            y = in[1];
            else if((sel[0]==1'b1) && (sel[1]==1'b0)) // sel = 10
            y = in[2];
            else                                      // sel = 11
            y = in[3];
       
        end  
       
 endmodule

