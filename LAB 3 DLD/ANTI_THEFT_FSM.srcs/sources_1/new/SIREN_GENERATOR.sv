`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2026 09:16:51 AM
// Design Name: 
// Module Name: SIREN_GENERATOR
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

module SIREN_GENERATOR #(
parameter SIM = 0
)(
input  logic clk,
input  logic rst,
input  logic Siren_Enable,
output logic Siren_Out
);

logic Tone_Select;
logic [26:0] Second_Counter;
logic [16:0] Tone_Counter;
logic Siren_Out_Reg;

localparam HALF_SECOND =
        (SIM) ? 500 : 50_000_000;

localparam TONE_440 =
        (SIM) ? 20 : 113636;

localparam TONE_880 =
        (SIM) ? 10 : 56818;

//////////////////////////
// Tone Switch
/////////////////////////

always_ff @(posedge clk or posedge rst)
begin
    if (rst || !Siren_Enable)
    begin
        Second_Counter <= 0;
        Tone_Select <= 0;
    end
    else if (Second_Counter >= HALF_SECOND-1)
    begin
        Second_Counter <= 0;
        Tone_Select <= ~Tone_Select;
    end
    else
        Second_Counter <= Second_Counter + 1;
end

//////////////////////////
// Tone Generator
//////////////////////////

always_ff @(posedge clk or posedge rst)
begin
  if(rst || !Siren_Enable)
  begin
   Tone_Counter <= 0;
   Siren_Out_Reg <= 0;
  end

  else
  
  begin
  if(Tone_Select == 0)
  
  begin
  if(Tone_Counter >= TONE_440)
  
  begin
  Tone_Counter <= 0;
  Siren_Out_Reg <= ~Siren_Out_Reg;
  end
  
  else
  Tone_Counter <= Tone_Counter + 1;
  end

  else
   begin
    
    if(Tone_Counter >= TONE_880)
    begin
    
    Tone_Counter <= 0;
    Siren_Out_Reg <= ~Siren_Out_Reg;
    end  
    
    else 
    
    Tone_Counter <= Tone_Counter + 1;
    
    end
    end
end

assign Siren_Out = Siren_Out_Reg;

endmodule