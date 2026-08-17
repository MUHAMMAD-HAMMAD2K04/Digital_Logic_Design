`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2026 09:35:30 AM
// Design Name: 
// Module Name: Decimal_BCD_Priority_Encoder_tb
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


module Decimal_BCD_Priority_Encoder_tb();
logic [3:0] Q;    
logic [8:0] A;

// Instantiating DUT 
Decimal_BCD_Priority_Encoder UUT (
    .Q(Q),
    .A(A)
);
    //Testing different test cases
initial begin

    A = 9'b111111111; #10; $display("A = %b, Q = %b", A, Q);
    A = 9'b010010100; #10; $display("A = %b, Q = %b", A, Q);
    A = 9'b000010101; #10; $display("A = %b, Q = %b", A, Q);
    A = 9'b010100101; #10; $display("A = %b, Q = %b", A, Q);
    A = 9'b000110101; #10; $display("A = %b, Q = %b", A, Q);
    A = 9'b000010001; #10; $display("A = %b, Q = %b", A, Q);
    A = 9'b000010000; #10; $display("A = %b, Q = %b", A, Q);
    $finish;
end    
endmodule
