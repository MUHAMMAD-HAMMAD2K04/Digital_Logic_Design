`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2026 09:34:31 AM
// Design Name: 
// Module Name: Decimal_BCD_Priority_Encoder
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


/*BCD Priority Encoder */
module Decimal_BCD_Priority_Encoder(
output logic [3:0] Q, 
input  logic [8:0] A
    );//Ports Declaration 

   always_comb
   begin
   casez (A)
  //Inputs       //Outputs      
  9'b0???????? : Q = 4'b1110;
  9'b10??????? : Q = 4'b1101;
  9'b110?????? : Q = 4'b1100;
  9'b1110????? : Q = 4'b1011;
  9'b11110???? : Q = 4'b1010; 
  9'b111110??? : Q = 4'b1001;
  9'b1111110?? : Q = 4'b1000;
  9'b11111110? : Q = 4'b0111;  
  9'b111111110 : Q = 4'b0110;
  default :  Q = 4'b1111;  
   endcase 
   end  
endmodule
