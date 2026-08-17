`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2026 12:33:01 PM
// Design Name: 
// Module Name: TIME_PARAMETERS_TB
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


module TIME_PARAMETERS_TB;

/////////////////////////////////////////
// Testbench Signals
/////////////////////////////////////////

logic clk;
logic rst;
logic [1:0] Time_Parameter_Selector;
logic [3:0] Time_Value;
logic Reprogram;
logic [1:0] Interval_Signal;

logic [3:0] Selected_Time_Value;

///////////////////////////////////////
// Instantiate DUT
///////////////////////////////////////

TIME_PARAMETERS DUT(
    .clk(clk),
    .rst(rst),
    .Time_Parameter_Selector(Time_Parameter_Selector),
    .Time_Value(Time_Value),
    .Reprogram(Reprogram),
    .Interval_Signal(Interval_Signal),
    .Selected_Time_Value(Selected_Time_Value)  
);

///////////////////////////////////////////////
// Clock (10 ns period = 100 MHz)
///////////////////////////////////////////////

initial clk = 0;
always #5 clk = ~clk;

/////////////////////////////
// Test Procedure
/////////////////////////////

initial
begin

    // Initialize inputs
    rst = 1;
    Reprogram = 0;
    Time_Parameter_Selector = 0;
    Time_Value = 0;
    Interval_Signal = 0;

    // Hold reset
    #20;
    rst = 0;

    ///////////////////////////////////
    // Check default values
    ///////////////////////////////////

    Interval_Signal = 2'b00;  // should output 6
    #20;

    Interval_Signal = 2'b01;  // should output 8
    #20;

    Interval_Signal = 2'b10;  // should output 15
    #20;

    Interval_Signal = 2'b11;  // should output 10
    #20;

    ///////////////////////////////
    // Reprogram parameter
    ///////////////////////////////

    Time_Parameter_Selector = 2'b01; // select parameter 1
    Time_Value = 4'd5;               // new value
    Reprogram = 1;

    #10;
    Reprogram = 0;

    ///////////////////////////////////
    // Verify new value
    ///////////////////////////////////

    Interval_Signal = 2'b01; // should now output 5
    #20;

    /////////////////////////////////
    // Reprogram another parameter
    /////////////////////////////////

    Time_Parameter_Selector = 2'b11;
    Time_Value = 4'd12;
    Reprogram = 1;

    #10;
    Reprogram = 0;

    Interval_Signal = 2'b11; // should output 12
    #20;

    ///////////////////////////
    // End Simulation
    ///////////////////////////

    $stop;

end

/////////////////////////////////
// Monitor signals
/////////////////////////////////

initial
begin
    $display("Time\tRST\tReprog\tSelector\tInterval\tValue\tSelected");
    $monitor("%0t\t%b\t%b\t%0d\t\t%0d\t\t%0d\t%0d",
              $time, rst, Reprogram, Time_Parameter_Selector,
              Interval_Signal, Time_Value,
              Selected_Time_Value);
end

endmodule