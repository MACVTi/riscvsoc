// The privilege multiplexor module for the CPU
// Written by Jack McEllin - 15170144

module mux_privilege(
        input wire I_exception,        //interrupt select
		input wire I_privsel,
		input wire [31:0] I_mevect,
		input wire [31:0] I_data1,
		input wire [31:0] I_data2,
		output wire [31:0] O_data
	  );

    assign O_data = (I_exception == 1'b1) ? I_mevect : ((I_privsel == 1'b0) ? I_data1 : I_data2);

endmodule
