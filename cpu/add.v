// A 32 bit adder module
// Written by Jack McEllin - 15170144

module add(
    input [31:0] I_data1,
    input [31:0] I_data2,
    output [31:0] O_data
    );

	assign O_data = I_data1 + I_data2;	

endmodule
