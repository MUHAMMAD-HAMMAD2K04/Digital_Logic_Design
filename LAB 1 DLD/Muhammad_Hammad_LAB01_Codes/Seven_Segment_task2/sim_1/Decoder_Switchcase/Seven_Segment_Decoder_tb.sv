`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2026 01:38:54 PM
// Design Name: 
// Module Name: Seven_Segment_Decoder_tb
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


module Seven_Segment_Decoder_tb();

    // Testbench signals
    logic A, B, C, D;
    logic [7:0] an;
    logic [6:0] op;

    // Instantiate DUT
    Seven_Segment_Decoder DUT (.*);

    initial begin

        $display(" A B C D  |  op0 op1 op2 op3 op4 op5 op6 ");

        // 0
        A=0; B=0; C=0; D=0; #10;
        $display(" %b %b %b %b  |   %b  %b  %b  %b  %b  %b  %b ", A,B,C,D,op[0],op[1],op[2],op[3],op[4],op[5],op[6]);

        // 1
        A=0; B=0; C=0; D=1; #10;
        $display(" %b %b %b %b  |   %b  %b  %b  %b  %b  %b  %b ", A,B,C,D,op[0],op[1],op[2],op[3],op[4],op[5],op[6]);

        // 2
        A=0; B=0; C=1; D=0; #10;
        $display(" %b %b %b %b  |   %b  %b  %b  %b  %b  %b  %b ", A,B,C,D,op[0],op[1],op[2],op[3],op[4],op[5],op[6]);

        // 3
        A=0; B=0; C=1; D=1; #10;
        $display(" %b %b %b %b  |   %b  %b  %b  %b  %b  %b  %b ", A,B,C,D,op[0],op[1],op[2],op[3],op[4],op[5],op[6]);

        // 4
        A=0; B=1; C=0; D=0; #10;
        $display(" %b %b %b %b  |   %b  %b  %b  %b  %b  %b  %b ", A,B,C,D,op[0],op[1],op[2],op[3],op[4],op[5],op[6]);

        // 5
        A=0; B=1; C=0; D=1; #10;
        $display(" %b %b %b %b  |   %b  %b  %b  %b  %b  %b  %b ", A,B,C,D,op[0],op[1],op[2],op[3],op[4],op[5],op[6]);

        // 6
        A=0; B=1; C=1; D=0; #10;
        $display(" %b %b %b %b  |   %b  %b  %b  %b  %b  %b  %b ", A,B,C,D,op[0],op[1],op[2],op[3],op[4],op[5],op[6]);

        // 7
        A=0; B=1; C=1; D=1; #10;
        $display(" %b %b %b %b  |   %b  %b  %b  %b  %b  %b  %b ", A,B,C,D,op[0],op[1],op[2],op[3],op[4],op[5],op[6]);

        // 8
        A=1; B=0; C=0; D=0; #10;
        $display(" %b %b %b %b  |   %b  %b  %b  %b  %b  %b  %b ", A,B,C,D,op[0],op[1],op[2],op[3],op[4],op[5],op[6]);

        // 9
        A=1; B=0; C=0; D=1; #10;
        $display(" %b %b %b %b  |   %b  %b  %b  %b  %b  %b  %b ", A,B,C,D,op[0],op[1],op[2],op[3],op[4],op[5],op[6]);

        $stop;
    end

endmodule

