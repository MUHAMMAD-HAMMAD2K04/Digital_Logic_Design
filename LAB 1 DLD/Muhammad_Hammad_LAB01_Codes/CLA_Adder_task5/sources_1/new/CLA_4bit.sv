`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2026 05:20:29 AM
// Design Name: 
// Module Name: CLA_4bit
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

    // ==========================================
    // 4-bit Carry Look Ahead Adder
    // ==========================================

module CLA_4bit(
      input  logic [3:0] A,
      input  logic [3:0] B,
      input  logic       Cin,
      output logic [3:0] Sum,
      output logic       Cout
    );
    
    
        // Generate and Propagate signals
        logic [3:0] G;   // Generate
        logic [3:0] P;   // Propagate
        logic [4:0] C;   // Carry signals
    
        assign C[0] = Cin;
    
        // Generate and Propagate equations
        assign G = A & B;       // Generator
        assign P = A ^ B;       // Propagator
    
        // Carry Look-Ahead Equations
        assign C[1] = G[0] | (P[0] & C[0]);
    
        assign C[2] = G[1] | 
                     (P[1] & G[0]) | 
                     (P[1] & P[0] & C[0]);
    
        assign C[3] = G[2] | 
                     (P[2] & G[1]) | 
                     (P[2] & P[1] & G[0]) | 
                     (P[2] & P[1] & P[0] & C[0]);
    
        assign C[4] = G[3] | 
                     (P[3] & G[2]) | 
                     (P[3] & P[2] & G[1]) | 
                     (P[3] & P[2] & P[1] & G[0]) | 
                     (P[3] & P[2] & P[1] & P[0] & C[0]);
    
        // Sum equation
        assign Sum  = P ^ C[3:0];
    
        assign Cout = C[4];
    
    
endmodule
