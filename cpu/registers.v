// The register module for the CPU
// Written by Jack McEllin - 15170144

`include "general_definitions.vh"

module registers(
	input wire I_clk,
	input wire I_rst,
	input wire I_regwen,
	input wire [3:0] I_rs1,
	input wire [3:0] I_rs2,
	input wire [3:0] I_rd,
	input wire [31:0] I_data,
	output wire [31:0] O_data1,
	output wire [31:0] O_data2
    );

	reg [31:0] register [15:1];
	integer i;
	
	assign O_data1 = (I_rs1 == 0) ? 32'h00000000 :register[I_rs1];
    assign O_data2 = (I_rs2 == 0) ? 32'h00000000 :register[I_rs2];

    initial begin
        for (i=1; i < 16; i=i+1) begin
            register[i] = 32'h00000000;
        end
    end

	always @(posedge I_clk) begin
	    $display("Stack Pointer = %h", register[2]);
	    
		if (I_rst == 1) begin
			for (i=1; i < 16; i=i+1) begin
				register[i] <= 32'h00000000;
			end
		end
		else if (I_regwen == 1) begin
            register[I_rd] <= I_data;
            $display("The value %h was stored in register x%d", I_data, I_rd);
        end
	end

endmodule
