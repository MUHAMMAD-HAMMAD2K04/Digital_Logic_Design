`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2026 07:24:31 AM
// Design Name: 
// Module Name: Decoder_7_Segment
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


module Decoder_7_Segment(
   input  logic A,
   input  logic B,
   input  logic C,
   input  logic D,
   output logic [7:0] AN,
   output logic [0:6] op
    );
    
        // Implementing equations (as interpreted from image)
    
        assign op[0] = (B & ~C & D) | (~A & ~B & ~C & D);
    
        assign op[1] = B & (C ^ D);
    
        assign op[2] = ~B & C & ~D;
    
        assign op[3] = (B & C & D) | (B & ~C & ~D) | (~A & ~B & ~C & D);
    
        assign op[4] = (B & ~C) | D;
    
        assign op[5] = (~A & ~B & D) | (C & D) | (~B & C);
    
        assign op[6] = (~A & ~B & ~C) | (B & C & D);
    
    // Enable first display only
            assign AN = 8'b11111110;
    
endmodule
