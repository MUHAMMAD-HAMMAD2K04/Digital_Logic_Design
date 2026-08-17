`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2026 07:27:29 AM
// Design Name: 
// Module Name: FSM_TM_SIM_TB
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


module FSM_TM_SIM_TB;

// Parameter
parameter SIM = 1;

// DUT Signals

logic clk;
logic rst;
logic Ignition_Switch;
logic Brake_Pedal_Switch;
logic Hidden_Switch;
logic Driver_Switch;
logic Passenger_Switch;
logic Reprogram;
logic [1:0] Time_Parameter_Selector;
logic [3:0] Time_Value;
logic Fuel_Pump_Power;
logic Blink_Signal;
logic Siren_Out;

// DUT
ANTI_THEFT_FSM_TM #(.SIM(SIM)) DUT (.*);

//CLK
initial clk = 0;
always #5 clk = ~clk;

///////////////////////////////
// Monitor
///////////////////////////////

initial begin
$monitor("T=%0t | Ign=%b Drv=%b Pas=%b | Fuel=%b Siren=%b Blink=%b",
$time,
Ignition_Switch,
Driver_Switch,
Passenger_Switch,
Fuel_Pump_Power,
Siren_Out,
Blink_Signal);
end

//////////////////////////////////
// Test Sequence
//////////////////////////////////

initial begin

// INITIALIZATION

Ignition_Switch = 0;
Brake_Pedal_Switch = 0;
Hidden_Switch = 0;
Driver_Switch = 0;
Passenger_Switch = 0;
Reprogram = 0;
Time_Parameter_Selector = 0;
Time_Value = 0;

//RESET

rst = 1;
#50;
rst = 0;

//////////////////////////////////////
// TEST 1: ARMING SEQUENCE
//////////////////////////////////////

$display("TEST1: Arm System");

Ignition_Switch = 0;

Driver_Switch = 1;
#100;

Driver_Switch = 0;
#300;

////////////////////////////////////////
// TEST 2: DRIVER DOOR TRIGGER
////////////////////////////////////////

$display("TEST2: Driver Door Trigger");

Driver_Switch = 1;
#500;

//////////////////////////////////////
// TEST 3: ALARM ACTIVE
//////////////////////////////////////

$display("TEST3: Alarm Sounding");

#500;

///////////////////////////////////////////
// TEST 4: CLOSE DOORS (Alarm wait timer)
///////////////////////////////////////////

$display("TEST4: Close Doors");

Driver_Switch = 0;
Passenger_Switch = 0;

#500;

//////////////////////////////////////////
// TEST 5: PASSENGER DOOR TRIGGER
//////////////////////////////////////////

$display("TEST5: Passenger Door Trigger");

Passenger_Switch = 1;
#500;
Passenger_Switch = 0;
#200;

////////////////////////////////////////
// TEST 6: IGNITION DISARM
////////////////////////////////////////

$display("TEST6: Ignition Disarm");

Ignition_Switch = 1;

#200;

Ignition_Switch = 0;

#200;

//////////////////////////////////////////
// TEST 7: FUEL PUMP ENABLE SEQUENCE
//////////////////////////////////////////

$display("TEST7: Fuel Pump Enable");

Ignition_Switch = 1;

#100;

Hidden_Switch = 1;
Brake_Pedal_Switch = 1;

#200;

Hidden_Switch = 0;
Brake_Pedal_Switch = 0;

#200;

////////////////////////////////////
// TEST 8: FUEL PUMP RESET
////////////////////////////////////

$display("TEST8: Fuel Pump Reset");

Ignition_Switch = 0;

#300;

//////////////////////////////////////////
// TEST 9: REPROGRAM TIME PARAMETERS
//////////////////////////////////////////

$display("TEST9: Reprogram Timer Parameters");

Time_Parameter_Selector = 2'b00;
Time_Value = 4'd3;

Reprogram = 1;

#50;

Reprogram = 0;

#200;

///////////////////////////////////////
// TEST 10: ZERO TIMER EDGE CASE
///////////////////////////////////////

$display("TEST10: Zero Delay Edge Case");

Time_Parameter_Selector = 2'b01;
Time_Value = 4'd0;

Reprogram = 1;

#50;

Reprogram = 0;

#200;

/////////////////////////////////////
// TEST 11: RAPID DOOR TOGGLING
/////////////////////////////////////

$display("TEST11: Rapid Door Toggle");

Driver_Switch = 1;
#100;
Driver_Switch = 0;
#100;
Driver_Switch = 1;
#100;
Driver_Switch = 0;
#100;
Driver_Switch = 1;
#100;
Driver_Switch = 0;

#500;

///////////////////////////
// END SIMULATION
///////////////////////////

$display("ALL TESTS COMPLETE");
#1000;
$finish;
end

endmodule