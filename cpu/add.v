`timescale 1ns / 1ps

module add(
    input [31:0] data_in1,
    input [31:0] data_in2,
    output [31:0] data_out
    );

	assign data_out = data_in1 + data_in2;	

endmodule
