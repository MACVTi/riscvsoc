`timescale 1ns / 1ps
module alu(
	input clk,
	input reset,
	input en,
	
	input [31:0] data_in_1;
	input [31:0] data_in_2;
	input [2:0] aluop;

	output reg [31:0] data_out;
    );


endmodule
