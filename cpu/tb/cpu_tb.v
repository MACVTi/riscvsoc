module cpu_tb;
	
	//Declare Registers and Wires
	reg clk;
	reg reset;

	//Instantiate Modules
    cpu cpu(
    .clk(clk), .reset(reset)
    );

	// Start running clock
	always begin
		#10 clk = ~clk;
	end

	initial begin
		// Initialise testbench
        clk = 0; reset = 1;
        
        #10 reset = 0;
        
		// Write test values to registers
		// Finish simulation
		#200 $finish;
	end
	
endmodule
