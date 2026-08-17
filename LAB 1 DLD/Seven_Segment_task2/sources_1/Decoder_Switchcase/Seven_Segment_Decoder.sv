`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2026 06:14:11 AM
// Design Name: 
// Module Name: Seven_Segment_Decoder
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


module Seven_Segment_Decoder(
input logic A,
input logic B,
input logic C,
input logic D,
output logic [7:0] an,
output logic [6:0] op); //Ports Declaration  
    always_comb
    begin
    
    case({A, B, C, D})
    4'b0000 : op = 7'b0000001;
    4'b0001 : op = 7'b1001111;
    4'b0010 : op = 7'b0010010;
    4'b0011 : op = 7'b0000110;
    4'b0100 : op = 7'b1001100;
    4'b0101 : op = 7'b0100100;
    4'b0110 : op = 7'b0100000;
    4'b0111 : op = 7'b0001111;
    4'b1000 : op = 7'b0000000;
    4'b1001 : op = 7'b0000100;
    endcase    
    end
    
    assign an = 8'b11111110;
endmodule
