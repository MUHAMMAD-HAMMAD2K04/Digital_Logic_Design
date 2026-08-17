`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2026 09:07:29 PM
// Design Name: 
// Module Name: Barrel_Shifter_tb
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
// =======================================
// 4x1 Multiplexer
// =======================================
module Mux_4x1(
    output logic y, 
    input  logic [3:0] in,
    input  logic [1:0] sel
);

    // Clean implementation
    assign y = in[sel];

endmodule


// =======================================
// Left Logical Barrel Shifter
// =======================================
module Left_BS(
    output logic [3:0] y,
    input  logic [3:0] w,
    input  logic [1:0] s
);

    // s=00 ? no shift
    // s=01 ? <<1
    // s=10 ? <<2
    // s=11 ? <<3

    Mux_4x1 mux0(.y(y[3]), .in({w[0], w[1], w[2], w[3]}), .sel(s));
    Mux_4x1 mux1(.y(y[2]), .in({1'b0, w[0], w[1], w[2]}), .sel(s));
    Mux_4x1 mux2(.y(y[1]), .in({1'b0, 1'b0, w[0], w[1]}), .sel(s));
    Mux_4x1 mux3(.y(y[0]), .in({1'b0, 1'b0, 1'b0, w[0]}), .sel(s));

endmodule


// =======================================
// Right Logical Barrel Shifter
// =======================================
module Right_BS(
    output logic [3:0] y,
    input  logic [3:0] w,
    input  logic [1:0] s
);

    // s=00 ? no shift
    // s=01 ? >>1
    // s=10 ? >>2
    // s=11 ? >>3

    Mux_4x1 mux0(.y(y[3]), .in({1'b0, 1'b0, 1'b0, w[3]}), .sel(s));
    Mux_4x1 mux1(.y(y[2]), .in({1'b0, 1'b0, w[3], w[2]}), .sel(s));
    Mux_4x1 mux2(.y(y[1]), .in({1'b0, w[3], w[2], w[1]}), .sel(s));
    Mux_4x1 mux3(.y(y[0]), .in({w[3], w[2], w[1], w[0]}), .sel(s));

endmodule


// =======================================
// Right Rotate Barrel Shifter
// =======================================
module Right_Rotate_BS(
    output logic [3:0] y,
    input  logic [3:0] w,
    input  logic [1:0] s
);

    // s=00 ? no rotate
    // s=01 ? rotate right 1
    // s=10 ? rotate right 2
    // s=11 ? rotate right 3

    Mux_4x1 mux0(.y(y[3]), .in({w[0], w[1], w[2], w[3]}), .sel(s));
    Mux_4x1 mux1(.y(y[2]), .in({w[3], w[0], w[1], w[2]}), .sel(s));
    Mux_4x1 mux2(.y(y[1]), .in({w[2], w[3], w[0], w[1]}), .sel(s));
    Mux_4x1 mux3(.y(y[0]), .in({w[1], w[2], w[3], w[0]}), .sel(s));

endmodule


// =======================================
// Top Barrel Shifter
// =======================================
module Barrel_Shifter(
    output logic [3:0] y,
    input  logic [3:0] w,
    input  logic [1:0] s,
    input  logic [1:0] Sel_mode
);

    logic [3:0] Left_Out, Right_Out, Rotate_Out;

    // Instantiate all three shifters
    Left_BS         BS1(.y(Left_Out),   .w(w), .s(s));
    Right_BS        BS2(.y(Right_Out),  .w(w), .s(s));
    Right_Rotate_BS BS3(.y(Rotate_Out), .w(w), .s(s));

    always_comb begin
        case(Sel_mode)
            2'b00: y = Left_Out;     // Left shift
            2'b01: y = Right_Out;    // Right shift
            2'b10: y = Rotate_Out;   // Rotate right
            default: y = 4'b0000;
        endcase
    end

endmodule