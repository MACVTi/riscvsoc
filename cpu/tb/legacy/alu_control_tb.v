module alu_control_tb;
	
	//Declare Registers and Wires

	//Instantiate Modules
    alu_control alu_control(.clk(clk), .data_in1(data_in1), .data_in2(data_in2), .data_out(data_out));

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
