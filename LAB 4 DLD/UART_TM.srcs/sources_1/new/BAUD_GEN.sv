`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2026 05:45:09 PM
// Design Name: 
// Module Name: BAUD_GEN
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


module BAUD_GEN (
    input  logic sys_clk,
    input  logic [1:0] sel_baud,
    output logic bclk,
    output logic bclkx8
);

parameter SYS_CLK = 100_000_000;

logic [31:0] divisor;
logic [31:0] counter;

always_comb begin
    case(sel_baud)
        2'b00: divisor = SYS_CLK/9600;
        2'b01: divisor = SYS_CLK/19200;
        2'b10: divisor = SYS_CLK/38400;
        2'b11: divisor = SYS_CLK/115200;
    endcase
end

always_ff @(posedge sys_clk) begin

    counter <= counter + 1;

    if(counter >= divisor) begin
        counter <= 0;
        bclk <= ~bclk;
    end

    if(counter >= divisor/8) begin
        bclkx8 <= ~bclkx8;
    end

end

endmodule
