`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2026 11:34:01 AM
// Design Name: 
// Module Name: Clock_Divider_75k
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


module Clock_Divider_75k(
    input  logic clk,     // 100 MHz
    input  logic rst,
    output logic clk_out  // ~75 kHz
);

logic [10:0] counter;   // enough for 1333

always_ff @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        counter <= 0;
        clk_out <= 0;
    end
    else
    begin
        if (counter == 665)
        begin
            counter <= 0;
            clk_out <= ~clk_out;   // toggle output
        end
        else
            counter <= counter + 1;
    end
end

endmodule