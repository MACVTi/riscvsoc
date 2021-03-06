// Written by Jack McEllin - 15170144
// A testbench for testing a two-input multiplexor

module mux2_tb;
	
	//Declare Registers and Wires
	reg clk;
	reg sel;	
	reg [31:0] source_1;
	reg [31:0] source_2;
	wire [31:0] destination;

	//Instantiate Modules
	mux2 mux2(.I_sel(sel), .I_data1(source_1), .I_data2(source_2), .O_data(destination));

	// Start running clock
	always begin
		#5 clk = ~clk;
	end

	initial begin
		// Initialise testbench
		clk = 1; sel = 0; source_1 = 32'h00000001; source_2 = 32'h00000002;
	
		// Change selected source
		#10 sel = 1;
		
		// Finish simulation
		#10 $finish;
	end
	
endmodule
