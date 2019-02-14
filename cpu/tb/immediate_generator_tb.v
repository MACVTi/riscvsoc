// Written by Jack McEllin - 15170144
// A testbench for testing the program counter

module immediate_generator_tb;
	
	//Declare Registers and Wires
	reg clk;
    reg [31:0] data_in;
    wire [31:0] data_out;

	//Instantiate Modules
    immediate_generator immediate_generator(.I_immsel(), .I_data(), .O_data());    

	initial begin
		// Initialise testbench
        clk = 0; data_in = 32'h00000000;
        
		// Change value in PC
		#10 data_in = 32'h00000004;
		
		// Finish simulation
		#10 $finish;
	end
	
endmodule
