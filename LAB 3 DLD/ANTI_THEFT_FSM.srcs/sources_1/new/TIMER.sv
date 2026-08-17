`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2026 09:16:51 AM
// Design Name: 
// Module Name: TIME_PARAMETERS
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

//////////////////////////////////
// TIMER MODULE 
//////////////////////////////////
module TIMER #(parameter SIM = 0) // Simulation: 1 = fast, 0 = real timing
(
    input  logic rst,
    input  logic clk,                       // 100 MHz clock
    input  logic Start_Timer,               // start signal from FSM
    input  logic [3:0] Selected_Time_Value,// value from time parameter module
    output logic Expired_Signal,            // asserted when timer reaches 0
    output logic Blink_Signal               // Blink signal for LED 2 sec
);

    // Internal signals
    logic [3:0] counter;
    logic enable_1Hz;
    logic [26:0] counter_25; // large enough for 100M cycles

    // Start_Timer edge detection
    logic Start_Timer_d;
    logic start_pulse;

    // 1 Hz period (simulation vs FPGA)
    localparam ONE_HZ_COUNT = (SIM) ? 2 : 100_000_000;

    //////////////////////////////
    // Start_Timer edge detector
    //////////////////////////////
    always_ff @(posedge clk or posedge rst) begin
        if(rst)
            Start_Timer_d <= 0;
        else
            Start_Timer_d <= Start_Timer;
    end

    assign start_pulse = Start_Timer & ~Start_Timer_d;

    /////////////////////////
    // 1 Hz enable generator
    /////////////////////////
    always_ff @(posedge clk or posedge rst) begin
        if (rst || start_pulse) begin
            counter_25 <= 0;
            enable_1Hz <= 0;
            Blink_Signal <= 0;
        end
        else if (counter_25 == ONE_HZ_COUNT - 1) begin
            counter_25 <= 0;
            enable_1Hz <= 1;
            Blink_Signal <= ~Blink_Signal;
        end
        else begin
            counter_25 <= counter_25 + 1;
            enable_1Hz <= 0;
        end
    end

    /////////////////////////////
    // Countdown Timer
    /////////////////////////////
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            Expired_Signal <= 0;
        end
        else if (start_pulse) begin
            counter <= Selected_Time_Value;
            Expired_Signal <= 0;
        end
        else if (enable_1Hz && counter > 1) begin
            counter <= counter - 1;
        end
        else if (enable_1Hz && counter == 1) begin
            counter <= 0;
            Expired_Signal <= 1;
        end
    end

endmodule