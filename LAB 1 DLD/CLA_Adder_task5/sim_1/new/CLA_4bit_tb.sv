`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2026 05:27:16 AM
// Design Name: 
// Module Name: CLA_4bit_tb
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


module CLA_4bit_tb();

logic [3:0] A;
logic [3:0] B;
logic       Cin;
logic [3:0] Sum;
logic       Cout;

//Instantiating CLA_4bit

CLA_4bit DUT(.*);

 initial
    begin

 $display(" A     B    Cin  |  Sum   Cout ");
 $display("----------------------------------");

        // Test Case 1
        A = 4'b0000; B = 4'b0000; Cin = 0; #10;
        $display("%b  %b   %b   |  %b    %b", A, B, Cin, Sum, Cout);

        // Test Case 2
        A = 4'b0101; B = 4'b0011; Cin = 0; #10;
        $display("%b  %b   %b   |  %b    %b", A, B, Cin, Sum, Cout);

        // Test Case 3 (with carry in)
        A = 4'b0110; B = 4'b0101; Cin = 1; #10;
        $display("%b  %b   %b   |  %b    %b", A, B, Cin, Sum, Cout);

        // Test Case 4 (overflow case)
        A = 4'b1111; B = 4'b0001; Cin = 0; #10;
        $display("%b  %b   %b   |  %b    %b", A, B, Cin, Sum, Cout);

        // Test Case 5 (maximum values)
        A = 4'b1111; B = 4'b1111; Cin = 1; #10;
        $display("%b  %b   %b   |  %b    %b", A, B, Cin, Sum, Cout);

        $finish;
    end 

endmodule
