module decode_tb;
	
	//Declare Registers and Wires
    reg clk;

	//Instantiate Modules
    decode decode(.clk(clk), .data_in1(data_in1), .data_in2(data_in2), .data_out(data_out));

	// Start running clock
	always begin
		#10 clk = ~clk;
	end

	initial begin
		// Initialise testbench

		// Write test values to registers
		// Finish simulation
		#10 $finish;
	end
	
endmodule
