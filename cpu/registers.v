// Written by Jack McEllin - 15170144
// This file contains all the registers of the CPU
`define ZERO 32'h00000000

module registers(
	input wire I_clk,
	input wire I_rst,
	input wire I_regwen,
	input wire [3:0] I_rs1,
	input wire [3:0] I_rs2,
	input wire [3:0] I_rd,
	input wire [31:0] I_data,
	output reg [31:0] O_data1,
	output reg [31:0] O_data2
    );

	integer i;

	reg [31:0] register [15:1];

	always @(posedge I_clk) begin
		if (I_rst) begin
			for (i=1; i <= 15; i=i+1) begin
				register[i] <= `ZERO;
			end
			O_data1 <= `ZERO;
			O_data2 <= `ZERO;
		end

		if (I_regwen == 1) begin
			register[I_rd] <= I_data;
		end
		else begin
			if (I_rs1 == 4'b0000) begin
				O_data1 <= `ZERO;
			end
			else begin
				O_data1 <= register[I_rs1];
			end

			if (I_rs2 == 4'b0000) begin
				O_data2 <= `ZERO;
			end
			else begin
				O_data2 <= register[I_rs2];
			end
		end
	end

endmodule
