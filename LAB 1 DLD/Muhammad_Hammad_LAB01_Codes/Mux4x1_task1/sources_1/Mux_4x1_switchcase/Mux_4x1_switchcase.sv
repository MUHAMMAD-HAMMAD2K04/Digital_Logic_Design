`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2026 10:21:11 PM
// Design Name: 
// Module Name: Mux_4x1_switchcase
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

/*LAB TASK 1.3
Create a System Verilog module to implement one -bit wide 4-to-1 multiplexer using Case
Statements.*/

module Mux_4x1_switchcase(
output logic y, 
input logic [1:0] sel, 
input logic [3:0] in
); //Ports Declaration 

    always@(*) //Combinational Block
    begin
        case(sel)
            2'b00 :   y = in[0];
            2'b01 :   y = in[1];
            2'b10 :   y = in[2];     
            2'b11 :   y = in[3];
            default : y = 1'b0;
            endcase    
   end
endmodule
