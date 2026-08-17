`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2026 11:37:36 AM
// Design Name: 
// Module Name: Shift_Register
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 

// Create Date: 03/06/2026
// Module Name: Shift_Register
// Description: 8-bit Shift Register with shift/rotate left/right
//////////////////////////////////////////////////////////////////////////////////


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


module Shift_Register(
    input  logic [1:0] CTRL,
    input  logic S_IN,
    input  logic CLK,
    input  logic RST,
    output logic [7:0] Q,
    output logic S_OUT
);


Clock_Divider clk_div(
    .RST(RST),
    .CLK(CLK)
);

// Shift register triggered by the divided clock
always @(posedge CLK or posedge RST) begin
    if (RST)
        Q <= 8'b00000000;
    else begin
        case(CTRL)
            2'b00: Q <= {S_IN, Q[7:1]};   // shift right
            2'b01: Q <= {Q[6:0], S_IN};   // shift left
            2'b10: Q <= {Q[0], Q[7:1]};   // rotate right
            2'b11: Q <= {Q[6:0], Q[7]};   // rotate left
            default: Q <= Q;
        endcase
    end
end

assign S_OUT = Q[0];   // serial output

endmodule

