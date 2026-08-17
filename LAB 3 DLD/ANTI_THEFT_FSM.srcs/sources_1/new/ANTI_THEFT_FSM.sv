`timescale 1ns / 1ps

module ANTI_THEFT_FSM(

input  logic clk,
input  logic rst,
input  logic Ignition_Switch,
input  logic Driver_Door,
input  logic Passenger_Door,
input  logic Blink_Signal,
input  logic Reprogram,
input  logic Expired_Signal,
output logic [1:0] Interval_Signal,
output logic Start_Timer,
output logic Siren_Enable,
output logic Status_Indicator_Led

);

/////////////////////////
// STATE DEFINITIONS
/////////////////////////

typedef enum logic [2:0] {

ARMED,              // S0
ARMED_DELAY,        // S1
TRIGGERED,          // S2
SOUND_ALARM,        // S3
ALARM_WAIT_DOORS,   // S4
DISARMED            // S5

} State_t;

State_t State, Next_State;


// STATE REGISTER
always_ff @(posedge clk or posedge rst)
begin
    if (rst)
        State <= ARMED;
    else if (Reprogram)
        State <= ARMED;
    else
        State <= Next_State;
end


// NEXT STATE LOGIC

always_comb
begin

Next_State  = State;
Start_Timer = 0;
Interval_Signal = 2'b00;

case(State)

//////////////////////
// ARMED
//////////////////////

ARMED:
begin
    if (Ignition_Switch)
        Next_State = DISARMED;

    else if (Driver_Door)
    begin
    Start_Timer     = 1;
    Interval_Signal = 2'b01; // Driver delay
    Next_State      = TRIGGERED;
    end
        
    else if (Passenger_Door)
    begin
    Start_Timer     = 1;
    Interval_Signal = 2'b10; // Passenger delay
    Next_State      = TRIGGERED;
    end
    
    else
        Next_State = ARMED;
end

////////////////////////////
// ARMED_DELAY
////////////////////////////

ARMED_DELAY:
begin

    if(Ignition_Switch)
    Next_State = DISARMED;

    else if(Expired_Signal)
    Next_State = ARMED;
    
    else
    Next_State = ARMED_DELAY;
end

//////////////////////////
// TRIGGERED
//////////////////////////

TRIGGERED:
begin
    if (Ignition_Switch)
        Next_State = DISARMED;

    else if (Expired_Signal)
        Next_State = SOUND_ALARM;

    else
        Next_State = TRIGGERED;
end

////////////////////////
// SOUND ALARM
////////////////////////

SOUND_ALARM:
begin
    if (Ignition_Switch)
        Next_State = DISARMED;

    else if (!Driver_Door && !Passenger_Door)
     begin
        Start_Timer     = 1;
        Interval_Signal = 2'b11; // Alarm ON time
        Next_State      = ALARM_WAIT_DOORS;
     end
    
    
    else
        Next_State = SOUND_ALARM;
end

////////////////////////////
// ALARM WAIT DOORS
////////////////////////////

ALARM_WAIT_DOORS:
begin
    if (Ignition_Switch)
        Next_State = DISARMED;

    else if (Expired_Signal)
        Next_State = ARMED;

    else
        Next_State = ALARM_WAIT_DOORS;
end

///////////////////////////
// DISARMED
///////////////////////////

DISARMED:
begin
    if (!Ignition_Switch && Driver_Door)
    begin
            Start_Timer     = 1;
            Interval_Signal = 2'b00; // ARM delay
            Next_State      = ARMED_DELAY;
    end
    
    else
        Next_State = DISARMED;
end

endcase

end

//////////////////////////
// OUTPUT LOGIC
//////////////////////////
always_comb
begin

case(State)

//////////////////////////
// ARMED
//////////////////////////

ARMED:
begin
    Siren_Enable = 0;
    Status_Indicator_Led = Blink_Signal;
    
    
end

///////////////////////////
// ARM_DELAY
///////////////////////////

ARMED_DELAY:
begin
    Siren_Enable = 0;
    Status_Indicator_Led   = 0;
end

/////////////////////////
// TRIGGERED
/////////////////////////
TRIGGERED:
begin
    Status_Indicator_Led = 1;
    Siren_Enable = 0;

end

////////////////////////
// SOUND ALARM
////////////////////////

SOUND_ALARM:
begin
    Siren_Enable = 1;
    Status_Indicator_Led = 1;
end

////////////////////////
// ALARM WAIT DOORS
////////////////////////

ALARM_WAIT_DOORS:
begin
    Siren_Enable = 1;
    Status_Indicator_Led = 1;

end

////////////////////////
// DISARMED
////////////////////////

DISARMED:
begin
    Siren_Enable = 0;
    Status_Indicator_Led = 0;
end
endcase
end
endmodule