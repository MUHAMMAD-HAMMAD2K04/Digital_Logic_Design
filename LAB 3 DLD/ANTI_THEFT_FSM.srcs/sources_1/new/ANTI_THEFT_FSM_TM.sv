`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2026 07:27:29 AM
// Design Name: 
// Module Name: ANTI_THEFT_FSM_TM
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

module ANTI_THEFT_FSM_TM #(parameter SIM = 0)    // Set SIM=1 for fast simulation
(

// Inputs

input  logic clk,
input  logic rst,
input  logic Ignition_Switch,
input  logic Brake_Pedal_Switch,
input  logic Hidden_Switch,
input  logic Driver_Switch,
input  logic Passenger_Switch,
input  logic Reprogram,
input  logic [1:0] Time_Parameter_Selector,
input  logic [3:0] Time_Value,

// Outputs

output logic Fuel_Pump_Power,
output logic Blink_Signal,
output logic Siren_Out
);


// Internal Signals

logic ign, brk, hid, drv, pas, reprog;
logic Start_Timer;
logic [1:0] Interval_Signal;
logic [3:0] Selected_Time_Value;
logic Expired_Signal;
logic Siren_Enable;
logic Status_LED;


// Debouncers

DEBOUNCER #(.SIM(SIM)) D1 (.reset_in(rst), .clock_in(clk), .noisy_in(Ignition_Switch), .clean_out(ign));
DEBOUNCER #(.SIM(SIM)) D2 (.reset_in(rst), .clock_in(clk), .noisy_in(Brake_Pedal_Switch), .clean_out(brk));
DEBOUNCER #(.SIM(SIM)) D3 (.reset_in(rst), .clock_in(clk), .noisy_in(Hidden_Switch), .clean_out(hid));
DEBOUNCER #(.SIM(SIM)) D4 (.reset_in(rst), .clock_in(clk), .noisy_in(Driver_Switch), .clean_out(drv));
DEBOUNCER #(.SIM(SIM)) D5 (.reset_in(rst), .clock_in(clk), .noisy_in(Passenger_Switch), .clean_out(pas));
DEBOUNCER #(.SIM(SIM)) D6 (.reset_in(rst), .clock_in(clk), .noisy_in(Reprogram), .clean_out(reprog));


// Fuel Pump FSM

FUEL_PUMP_FSM fuelFSM (
    .clk(clk),
    .rst(rst),
    .Ignition_Switch(ign),
    .Hidden_Switch(hid),
    .Brake_Pedal_Switch(brk),
    .Fuel_Pump_Power(Fuel_Pump_Power)
);


// Anti-Theft FSM

ANTI_THEFT_FSM alarmFSM (
    .clk(clk),
    .rst(rst),
    .Ignition_Switch(ign),
    .Driver_Door(drv),
    .Passenger_Door(pas),
    .Blink_Signal(Blink_Signal),
    .Reprogram(reprog),
    .Expired_Signal(Expired_Signal),
    .Interval_Signal(Interval_Signal),
    .Start_Timer(Start_Timer),
    .Siren_Enable(Siren_Enable),
    .Status_Indicator_Led(Status_LED)
);


// Time Parameter Memory

TIME_PARAMETERS timeParam (
    .clk(clk),
    .rst(rst),
    .Time_Parameter_Selector(Time_Parameter_Selector),
    .Time_Value(Time_Value),
    .Reprogram(reprog),
    .Interval_Signal(Interval_Signal),
    .Selected_Time_Value(Selected_Time_Value)
);

// Timer 

TIMER #(.SIM(SIM)) timerModule (
    .rst(rst),
    .clk(clk),
    .Start_Timer(Start_Timer),
    .Selected_Time_Value(Selected_Time_Value),
    .Expired_Signal(Expired_Signal),
    .Blink_Signal(Blink_Signal)
);

// Siren Generator 

SIREN_GENERATOR #(.SIM(SIM)) sirenGen (
    .clk(clk),
    .rst(rst),
    .Siren_Enable(Siren_Enable),
    .Siren_Out(Siren_Out)
);

endmodule