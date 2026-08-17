`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2026 08:51:07 AM
// Design Name: 
// Module Name: Frequency_Divider
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


module Frequency_Divider(
input  logic clk,rst,
output logic Y
    );
    logic clk1;
    logic [1:0] Q;
    logic [1:0] D;
    logic [1:0] Q_bar;
    
    assign D[0] = Q_bar[0];    
    assign D[1] = Q_bar[1];
    assign clk1 = Q[0];     
    assign Y = Q[1];
        
    
    FlipFlop FF1(.clk(clk),.rst(rst),.D(D[0]),.Q(Q[0]),.Q_bar(Q_bar[0]));
    FlipFlop FF2(.clk(clk1),.rst(rst),.D(D[1]),.Q(Q[1]),.Q_bar(Q_bar[1]));
    

endmodule

module FlipFlop(
input  clk,rst,
input logic  D,
output logic Q,
output logic Q_bar
);

always_ff@(posedge clk or posedge rst)
    begin
    if(rst) 
    Q<=1'b0;
    
    else
    Q<=D;
    
    end
    
    assign Q_bar = ~Q;

endmodule    