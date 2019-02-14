`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.01.2019 15:17:35
// Design Name: 
// Module Name: control
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


module control(
    input wire [31:0] I_instruction,
    input wire I_breq,
    input wire I_brlt,
    
    output reg [3:0] O_alusel,
    output reg [2:0] O_immsel,
    output reg [1:0] O_wbsel,
    output reg O_pcsel,
    output reg O_brun,
    output reg O_asel,
    output reg O_bsel,
    output reg O_memrw,
    output reg O_regwen
    );
    
    
endmodule
