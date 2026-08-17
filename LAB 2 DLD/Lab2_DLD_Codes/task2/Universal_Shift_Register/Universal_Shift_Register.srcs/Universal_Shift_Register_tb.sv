`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2026 01:15:39 AM
// Design Name: 
// Module Name: Universal_Shift_Register_tb
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


`timescale 1ns / 1ps

module Universal_Shift_Register_tb();

logic CLK;
logic RST;
logic [1:0] SEL;
logic [3:0] D;
logic S_IN_L;
logic S_IN_R;
logic [3:0] Q;


// DUT
Universal_Shift_Register dut(

.CLK(CLK),
.RST(RST),
.SEL(SEL),
.D(D),
.S_IN_L(S_IN_L),
.S_IN_R(S_IN_R),
.Q(Q)

);


// Clock generation
initial CLK = 1'b0;

 always
  begin
    #5 CLK = ~CLK; // 100MHz equivalent for sim
   end


initial
begin

RST = 1;
SEL = 2'b00;
D   = 4'b0000;
S_IN_L = 1'b0;
S_IN_R = 1'b0;

#20
RST = 0;

// Parallel load
SEL = 2'b11;
D = 4'b1011;

#50

// Shift right
SEL = 2'b01;
S_IN_R = 1;

#50

// Shift left
SEL = 2'b10;
S_IN_L = 1;

#50

// Hold
SEL = 2'b00;

#50

$finish;

end

// Monitor outputs
    initial begin
        $monitor("Time=%0t | SEL=%b | S_IN_L=%b | S_IN_R=%b | Q=%b", 
                 $time, SEL, S_IN_L, S_IN_R, Q);
    end

endmodule