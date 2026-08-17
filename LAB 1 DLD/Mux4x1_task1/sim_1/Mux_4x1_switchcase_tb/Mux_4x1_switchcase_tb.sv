`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2026 10:28:23 PM
// Design Name: 
// Module Name: Mux_4x1_switchcase_tb
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


module Mux_4x1_switchcase_tb();
   
    // Inputs & Outputs
    logic y; 
    logic [1:0] sel; 
    logic [3:0] in;
    
    //Instantiating DUT for Mux_4x1_Behavioral
    Mux_4x1_switchcase DUT(.*);
    
    // Testing Different Test Cases
    initial
    begin
    
    in[0]=1'b1; in[1]=1'b0; in[2]=1'b0; in[3]=1'b0; sel[0]=1'b0; sel[1]=1'b0;  #10;
    $display("in[0] = %b, in[1] = %b, in[2] = %b, in[3] = %b, sel[0] = %b, sel[2] = %b, y = %b", in[0], in[1], in[2], in[3], sel[0], sel[1], y);
    
    in[0]=1'b0; in[1]=1'b1; in[2]=1'b0; in[3]=1'b0; sel[0]=1'b0; sel[1]=1'b1;  #10;
    $display("in[0] = %b, in[1] = %b, in[2] = %b, in[3] = %b, sel[0] = %b, sel[2] = %b, y = %b", in[0], in[1], in[2], in[3], sel[0], sel[1], y);
    
    in[0]=1'b1; in[1]=1'b1; in[2]=1'b1; in[3]=1'b0; sel[0]=1'b0; sel[1]=1'b1;  #10;
    $display("in[0] = %b, in[1] = %b, in[2] = %b, in[3] = %b, sel[0] = %b, sel[2] = %b, y = %b", in[0], in[1], in[2], in[3], sel[0], sel[1], y);
    
    in[0]=1'b0; in[1]=1'b0; in[2]=1'b1; in[3]=1'b1; sel[0]=1'b1; sel[1]=1'b0;  #10;
    $display("in[0] = %b, in[1] = %b, in[2] = %b, in[3] = %b, sel[0] = %b, sel[2] = %b, y = %b", in[0], in[1], in[2], in[3], sel[0], sel[1], y);
    
    in[0]=1'b1; in[1]=1'b0; in[2]=1'b1; in[3]=1'b1; sel[0]=1'b1; sel[1]=1'b1;  #10;
    $display("in[0] = %b, in[1] = %b, in[2] = %b, in[3] = %b, sel[0] = %b, sel[2] = %b, y = %b", in[0], in[1], in[2], in[3], sel[0], sel[1], y);
    
    $stop;
    end
endmodule
