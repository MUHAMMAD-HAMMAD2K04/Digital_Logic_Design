`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2026 06:05:13 AM
// Design Name: 
// Module Name: FUEL_PUMP_FSM
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


module FUEL_PUMP_FSM(
input logic clk,
input logic rst,
input logic Ignition_Switch,
input logic Hidden_Switch,
input logic Brake_Pedal_Switch,
output logic Fuel_Pump_Power
    );
    
// STATE DEFINITIONS    
typedef enum logic {S0,S1} State_t;

State_t State,Next_State;

// State register
always_ff @(posedge clk or posedge rst)
begin
if(rst)
State <= S0;
else
State <= Next_State;
end

// Next state logic
always_comb
begin
case(State)

S0:
if(!Ignition_Switch)
Next_State = S0;
else if (Ignition_Switch==1 && Hidden_Switch == 1 && Brake_Pedal_Switch == 1)
Next_State = S1;
else 
Next_State = S0;


S1:
if(Ignition_Switch)
Next_State = S1;
else if(!Ignition_Switch)
Next_State = S0;

default: Next_State = S0;

endcase
end

// Output logic
assign Fuel_Pump_Power = (State == S1);

endmodule

