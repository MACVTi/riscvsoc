// Written by Jack McEllin - 15170144
// This file contains all the registers of the CPU
`include "general_definitions.vh"

module msr(
	input wire I_clk,
	input wire I_rst,
	input wire I_regwen,
	input wire [3:0] I_rs,
	input wire [3:0] I_rd,
	input wire [31:0] I_data,
	output wire [31:0] O_data
    );

	reg [31:0] msr [3:0];
	
	assign O_data = msr[I_rs];

    initial begin
        for (integer i=1; i < 16; i=i+1) begin
            msr[i] <= 32'h00000000;
        end
    end

	always @(posedge I_clk) begin
		if (I_rst == 1) begin
			for (integer i=1; i < 16; i=i+1) begin
				msr[i] <= 32'h00000000;
			end
		end
		if (I_regwen == 1) begin
            msr[I_rd] <= I_data;
            $display("The value %h was stored in msr %d", I_data, I_rd);
        end
	end

endmodule
