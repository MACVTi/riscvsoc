// Written by Jack McEllin - 15170144
// A two-input multiplexor

module mux2(
		input wire sel,
		input wire [31:0] data_in1,
		input wire [31:0] data_in2,
		output wire [31:0] data_out
	  );

    assign data_out = sel ? data_in1 : data_in2;

endmodule
