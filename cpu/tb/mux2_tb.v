// Written by Jack McEllin - 15170144
// A testbench for testing a two-input multiplexor

module mux2_tb;
	
	//Declare Registers and Wires
	reg clk;
	reg sel;	
	reg [31:0] source_1;
	reg [31:0] source_2;
	wire [31:0] out;

	//Instantiate Modules
	mux2 mux2(.sel(sel), .data_in1(source_1), .data_in2(source_2), .data_out(out));

	// Start running clock
	always begin
		#5 clk = ~clk;
	end

	initial begin
		// Initialise testbench
		clk = 1; sel = 0; source_1 = 32'h0000FFFF; source_2 = 32'hFFFF0000;
	
		// Change selected source
		#10 sel = 1;
		
		// Finish simulation
		#10 $finish;
	end
	
endmodule
