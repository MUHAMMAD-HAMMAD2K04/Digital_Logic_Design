`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2026 08:32:02 PM
// Design Name: 
// Module Name: Shift_Register_tb
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


module Shift_Register_tb;

    // Inputs
    logic [1:0] CTRL;
    logic S_IN;
    logic CLK;
    logic RST;

    // Outputs
    logic [7:0] Q;
    logic S_OUT;

    // Instantiate DUT
    Shift_Register dut (
        .CTRL(CTRL),
        .S_IN(S_IN),
        .CLK(CLK),
        .RST(RST),
        .Q(Q),
        .S_OUT(S_OUT)
    );

    // Clock generation: 100 MHz
    initial CLK = 0;
    always #5 CLK = ~CLK;

    // Test stimulus
    initial begin
        // Reset
        RST = 1;
        CTRL = 2'b00;
        S_IN = 0;
        #20;
        RST = 0;

        // SHIFT RIGHT
        $display("--- SHIFT RIGHT ---");
        CTRL = 2'b00; 
        #10 S_IN = 1;
        #10 S_IN = 1;
        #10 S_IN = 0;
        #10 S_IN = 1;
        #10 S_IN = 0;
        #10 S_IN = 1;
        #10 S_IN = 0;
        #10 S_IN = 1;
         // wait some simulation time for shifts
        
                // ROTATE RIGHT
        $display("--- ROTATE RIGHT ---");
        CTRL = 2'b10;
        #80;

        // SHIFT LEFT
        $display("--- SHIFT LEFT ---");
        CTRL = 2'b01; 
        #10 S_IN = 1;
        #10 S_IN = 1;
        #10 S_IN = 0;
        #10 S_IN = 1;
        #10 S_IN = 0;
        #10 S_IN = 1;
        #10 S_IN = 0;
        #10 S_IN = 1;
 
        
        // ROTATE LEFT
        $display("--- ROTATE LEFT ---");
        CTRL = 2'b11;
        #80;

        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | CTRL=%b | S_IN=%b | Q=%b | S_OUT=%b", 
                 $time, CTRL, S_IN, Q, S_OUT);
    end

endmodule