`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2026 01:11:46 AM
// Design Name: 
// Module Name: Universal_Shift_Register
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


module Universal_Shift_Register(
input logic CLK,
input logic RST,
input logic [1:0] SEL,
input logic [3:0] D,
input logic S_IN_L,
input logic S_IN_R,
output logic [3:0] Q
);

Clock_Divider D1(CLK,RST); // Nexys A7 clock

always_ff @(posedge CLK or posedge RST)
begin
    if(RST)
        Q <= 4'b0000;

    else
        case(SEL)
            2'b00: Q <= Q;                 // Hold
            2'b01: Q <= {S_IN_R, Q[3:1]};  // Shift Right
            2'b10: Q <= {Q[2:0], S_IN_L};  // Shift Left
            2'b11: Q <= D;                 // Parallel Load
        endcase
end

endmodule

module Clock_Divider(

input  logic CLK,     // Nexys A7 clock
input  logic RST
);

logic slow_clk;
logic [26:0] count;   // enough for 100M


// Clock Divider : 1 second
always_ff @(posedge CLK or posedge RST)
begin
    if(RST)
    begin
        count <= 0;
        slow_clk <= 0;
    end

    else if(count == 100000000-1)
    begin
        count <= 0;
        slow_clk <= ~slow_clk;
    end

    else
        count <= count + 1;
end


endmodule
