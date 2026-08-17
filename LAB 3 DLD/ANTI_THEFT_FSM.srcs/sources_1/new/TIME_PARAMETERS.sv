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


module TIME_PARAMETERS(

input  logic clk,
input  logic rst,
input  logic [1:0] Time_Parameter_Selector,
input  logic [3:0] Time_Value,
input  logic Reprogram,
input  logic [1:0] Interval_Signal,
output logic [3:0] Selected_Time_Value
);

logic [3:0] memory [3:0];

///////////////////////////////////////////
// Memory initialization and reprogramming
///////////////////////////////////////////

always_ff @(posedge clk or posedge rst)
begin
    if (rst)
    begin
    // default values at power-on
    memory[0] <= 4'b0110; // T_ARM_DELAY = 6
    memory[1] <= 4'b1000; // T_DRIVER_DELAY = 8
    memory[2] <= 4'b1111; // T_PASSENGER_DELAY = 15
    memory[3] <= 4'b1010; // T_ALARM_ON = 10
    end

    else if (Reprogram)
    begin
    // user updates selected parameter
    memory[Time_Parameter_Selector] <= Time_Value;
    end
end

///////////////////////////////////////
// Parameter selection for timer
///////////////////////////////////////

assign Selected_Time_Value = memory[Interval_Signal];

endmodule