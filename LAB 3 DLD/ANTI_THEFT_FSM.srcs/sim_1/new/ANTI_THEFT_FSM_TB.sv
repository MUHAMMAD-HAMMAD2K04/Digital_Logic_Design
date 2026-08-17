`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2026 09:15:58 PM
// Design Name: 
// Module Name: ANTI_THEFT_FSM_TB
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

module ANTI_THEFT_FSM_TB;

// DUT SIGNALS

logic clk;
logic rst;
logic Ignition_Switch;
logic Driver_Door;
logic Passenger_Door;
logic Blink_Signal;
logic Reprogram;
logic Expired_Signal;
logic [1:0] Interval_Signal;
logic Start_Timer;
logic Siren_Enable;
logic Status_Indicator_Led;


// DUT INSTANTIATION
ANTI_THEFT_FSM DUT (.*);

// CLOCK GENERATION
initial
clk = 0;
always #5 clk = ~clk;   // 100 MHz simulation clock

// BLINK SIGNAL 
initial
Blink_Signal = 0;
always #20 Blink_Signal = ~Blink_Signal;

// INITIAL CONDITIONS
initial 
begin

rst = 1;
Ignition_Switch = 0;
Driver_Door = 0;
Passenger_Door = 0;
Expired_Signal = 0;
Reprogram = 0;

#20
rst = 0;

// TEST 1 : Reset ? ARMED
$display("TEST 1 : RESET -> ARMED");
#40;

// TEST 2 : DRIVER DOOR TRIGGER
$display("TEST 2 : DRIVER DOOR TRIGGER");
Driver_Door = 1;
#20
Driver_Door = 0;

// TEST 2 : DRIVER DOOR TRIGGER
$display("TEST 3 : ARMED_DELAY");
Ignition_Switch = 1;
#20
Expired_Signal = 1;


// DRIVER DELAY EXPIRES
#20
Expired_Signal = 1;
#10
Expired_Signal = 0;

// TEST 3 : SOUND ALARM
$display("TEST 3 : ALARM ACTIVE");

#40;

// TEST 4 : DOOR CLOSE ? ALARM WAIT
$display("TEST 4 : DOOR CLOSE");

Driver_Door = 0;
Passenger_Door = 0;

#20;


// ALARM TIMER EXPIRES
Expired_Signal = 1;

#10
Expired_Signal = 0;

// TEST 5 : PASSENGER TRIGGER
$display("TEST 5 : PASSENGER DOOR TRIGGER");

Passenger_Door = 1;
#20
Passenger_Door = 0;
#20
Expired_Signal = 1;
#10
Expired_Signal = 0;


// TEST 6 : IGNITION DISARM
$display("TEST 6 : IGNITION DISARM");

Ignition_Switch = 1;
#40
Ignition_Switch = 0;

// TEST 7 : ARM DELAY
$display("TEST 7 : ARM DELAY");

Driver_Door = 1;
#20
Driver_Door = 0;
#20
Expired_Signal = 1;
#10
Expired_Signal = 0;

// TEST 8 : REPROGRAM RESET
$display("TEST 8 : REPROGRAM RESET");

Reprogram = 1;
#10
Reprogram = 0;

// FINISH SIMULATION
#200
$display("SIMULATION FINISHED");
$finish;
end

// MONITOR SIGNALS
initial begin

$monitor(
"time=%0t | Ign=%b Driver=%b Pass=%b Exp=%b | Siren=%b LED=%b | Interval=%b StartTimer=%b",
$time,
Ignition_Switch,
Driver_Door,
Passenger_Door,
Expired_Signal,
Siren_Enable,
Status_Indicator_Led,
Interval_Signal,
Start_Timer
);

end
endmodule