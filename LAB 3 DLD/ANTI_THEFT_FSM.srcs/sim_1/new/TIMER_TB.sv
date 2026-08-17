`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2026 12:10:14 PM
// Design Name: 
// Module Name: TIMER_TB
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Testbench for TIMER module
//////////////////////////////////////////////////////////////////////////////////
module tb_TIMER;

    // Inputs
    logic clk;
    logic rst;
    logic Start_Timer;
    logic [3:0] Selected_Time_Value;

    // Outputs
    logic Expired_Signal;
    logic Blink_Signal;

    // Simulation parameter: 1 = fast, 0 = real timing
    parameter SIM = 1;

    // Instantiate the TIMER module
    TIMER #(.SIM(SIM)) uut (
        .clk(clk),
        .rst(rst),
        .Start_Timer(Start_Timer),
        .Selected_Time_Value(Selected_Time_Value),
        .Expired_Signal(Expired_Signal),
        .Blink_Signal(Blink_Signal)
    );

    // Clock generation: 100 MHz -> period 10 ns
    initial clk = 0;
    always #5 clk = ~clk; // 10 ns period

    // Test sequence
    initial begin
        // Initialize inputs
        rst = 1;
        Start_Timer = 0;
        Selected_Time_Value = 0;

        // Apply reset
        #20;
        rst = 0;

        // Test 1: Start timer with 5-second countdown
        Selected_Time_Value = 4'd5;
        Start_Timer = 1;
        #10; // keep Start_Timer high for 1 clk
        Start_Timer = 0;

        // Wait for Expired_Signal
        wait(Expired_Signal == 1);
        $display("Test 1 completed at time %0t ns, Expired_Signal = %b", $time, Expired_Signal);

        // Small delay
        #20;

        // Test 2: Start timer with 3-second countdown
        Selected_Time_Value = 4'd3;
        Start_Timer = 1;
        #10;
        Start_Timer = 0;

        wait(Expired_Signal == 1);
        $display("Test 2 completed at time %0t ns, Expired_Signal = %b", $time, Expired_Signal);

        // Finish simulation
        #50;
        $finish;
    end

    // Monitor signals
    initial begin
        $display("Time(ns)\tStart\tSelVal\tExpired\tBlink");
        $monitor("%0t\t%b\t%d\t%b\t%b", $time, Start_Timer, Selected_Time_Value, Expired_Signal, Blink_Signal);
    end

endmodule