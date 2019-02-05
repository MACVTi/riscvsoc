// Written by Jack McEllin - 15170144
// A testbench for testing the program counter

module add_tb;
	
	//Declare Registers and Wires
	reg clk;
    reg [31:0] data_in1;
    reg [31:0] data_in2;
    wire [31:0] data_out;

	//Instantiate Modules
    add add(.data_in1(data_in1), .data_in2(data_in2), .data_out(data_out));
    
	// Start running clock
	always begin
		#5 clk = ~clk;
	end

	initial begin
		// Initialise testbench
        clk = 1; data_in1 = 32'hffff0000; clk = 1; data_in2 = 32'h00000000;
        
		// Add four to data_in1
		#10 data_in2 = 32'h00000004;
		
		// Finish simulation
		#10 $finish;
	end
	
endmodule
