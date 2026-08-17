`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2026 11:01:12 AM
// Design Name: 
// Module Name: FUEL_PUMP_FSM_TB
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

module FUEL_PUMP_FSM_TB;

    // Testbench signals
    logic clk;
    logic rst;
    logic Ignition_Switch;
    logic Hidden_Switch;
    logic Brake_Pedal_Switch;
    logic Fuel_Pump_Power;

    // Instantiate DUT
    FUEL_PUMP_FSM dut (
        .clk(clk),
        .rst(rst),
        .Ignition_Switch(Ignition_Switch),
        .Hidden_Switch(Hidden_Switch),
        .Brake_Pedal_Switch(Brake_Pedal_Switch),
        .Fuel_Pump_Power(Fuel_Pump_Power)
    );

//////////////////////////////////////////////////
// Clock Generation (100 MHz)
//////////////////////////////////////////////////

always #5 clk = ~clk;

//////////////////////////////////////////////////
// Stimulus
//////////////////////////////////////////////////

initial
begin
    // Initialize signals
    clk = 0;
    rst = 1;
    Ignition_Switch = 0;
    Hidden_Switch = 0;
    Brake_Pedal_Switch = 0;

    // Apply reset
    #20;
    rst = 0;

    // Turn ignition ON but others OFF ? stay S0
    #20;
    Ignition_Switch = 1;

    // Turn hidden switch ON
    #20;
    Hidden_Switch = 1;

    // Press brake pedal ? should go to S1
    #20;
    Brake_Pedal_Switch = 1;

    // Turn ignition OFF ? return to S0
    #40;
    Ignition_Switch = 0;

    #40;
    $finish;
end

//////////////////////////////////////////////////
// Monitor signals
//////////////////////////////////////////////////

initial
begin
$monitor("Time=%0t Ignition=%b Hidden=%b Brake=%b FuelPump=%b",
         $time,Ignition_Switch,Hidden_Switch,Brake_Pedal_Switch,Fuel_Pump_Power);
end

endmodule
