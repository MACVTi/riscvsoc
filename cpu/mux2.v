// Written by Jack McEllin - 15170144
// A two-input multiplexor

module mux2(
		input wire I_sel,
		input wire [31:0] I_data1,
		input wire [31:0] I_data2,
		output wire [31:0] O_data
	  );

    assign O_data = (I_sel == 1'b0) ? I_data1 :  I_data2;

endmodule
