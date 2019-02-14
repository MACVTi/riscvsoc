// Written by Jack McEllin - 15170144
// A two-input multiplexor

module mux3(
		input wire [1:0] sel,
		input wire [31:0] data_in1,
		input wire [31:0] data_in2,
		input wire [31:0] data_in3,
		output wire [31:0] data_out
	  );

    assign data_out = (sel == 2'b00) ? data_in1 : 
                      (sel == 2'b01) ? data_in2 :
                      (sel == 2'b10) ? data_in3 : 
                      32'h00000000;

endmodule
