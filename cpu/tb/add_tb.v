// Written by Jack McEllin - 15170144
// A testbench for testing the 32 bit adder

module add_tb;
	
	//Declare Registers and Wires
	reg clk;
    reg [31:0] source_1;
    reg [31:0] source_2;
    wire [31:0] destination;

	//Instantiate Modules
    add add(.I_data1(source_1), .I_data2(source_2), .O_data(destination));
    
	// Start running clock
	always begin
		#5 clk = ~clk;
	end

	initial begin
		// Initialise testbench
        clk = 1; source_1 = 32'h00000001; source_2 = 32'h00000000;
        
		// Add four to data_in1
		#10 source_2 = 32'h00000001;
		
		// Finish simulation
		#10 $finish;
	end
	
endmodule
