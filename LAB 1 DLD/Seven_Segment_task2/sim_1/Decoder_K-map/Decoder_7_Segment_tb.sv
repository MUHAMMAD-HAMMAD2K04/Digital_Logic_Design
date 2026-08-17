`timescale 1ns / 1ps

module Decoder_7_Segment_tb();
   
    logic A, B, C, D;
    logic [7:0] AN;
    logic [0:6] op;

    // Instantiate DUT
    Decoder_7_Segment dut (
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .AN(AN),
        .op(op)
    );

    initial begin

        $display(" A B C D |  op      |   AN");
        $display("----------------------------------");

        // Test 0
        A=0; B=0; C=0; D=0; #10;
        $display(" %b %b %b %b | %b | %b", A,B,C,D,op,AN);

        // Test 1
        A=0; B=0; C=0; D=1; #10;
        $display(" %b %b %b %b | %b | %b", A,B,C,D,op,AN);

        // Test 2
        A=0; B=0; C=1; D=0; #10;
        $display(" %b %b %b %b | %b | %b", A,B,C,D,op,AN);

        // Test 3
        A=0; B=0; C=1; D=1; #10;
        $display(" %b %b %b %b | %b | %b", A,B,C,D,op,AN);

        // Test 4
        A=0; B=1; C=0; D=0; #10;
        $display(" %b %b %b %b | %b | %b", A,B,C,D,op,AN);

        // Test 5
        A=0; B=1; C=0; D=1; #10;
        $display(" %b %b %b %b | %b | %b", A,B,C,D,op,AN);

        // Test 6
        A=0; B=1; C=1; D=0; #10;
        $display(" %b %b %b %b | %b | %b", A,B,C,D,op,AN);

        // Test 7
        A=0; B=1; C=1; D=1; #10;
        $display(" %b %b %b %b | %b | %b", A,B,C,D,op,AN);

        // Test 8
        A=1; B=0; C=0; D=0; #10;
        $display(" %b %b %b %b | %b | %b", A,B,C,D,op,AN);

        // Test 9
        A=1; B=0; C=0; D=1; #10;
        $display(" %b %b %b %b | %b | %b", A,B,C,D,op,AN);

        // Test 10
        A=1; B=0; C=1; D=0; #10;
        $display(" %b %b %b %b | %b | %b", A,B,C,D,op,AN);

        // Test 11
        A=1; B=0; C=1; D=1; #10;
        $display(" %b %b %b %b | %b | %b", A,B,C,D,op,AN);

        // Test 12
        A=1; B=1; C=0; D=0; #10;
        $display(" %b %b %b %b | %b | %b", A,B,C,D,op,AN);

        // Test 13
        A=1; B=1; C=0; D=1; #10;
        $display(" %b %b %b %b | %b | %b", A,B,C,D,op,AN);

        // Test 14
        A=1; B=1; C=1; D=0; #10;
        $display(" %b %b %b %b | %b | %b", A,B,C,D,op,AN);

        // Test 15
        A=1; B=1; C=1; D=1; #10;
        $display(" %b %b %b %b | %b | %b", A,B,C,D,op,AN);

        $finish;
    end

endmodule