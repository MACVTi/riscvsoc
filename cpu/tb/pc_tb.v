// Written by Jack McEllin - 15170144
// A testbench for testing the program counter

module pc_tb;
	
	//Declare Registers and Wires
	reg clk;
	reg reset;
    reg [31:0] data_in;
    wire [31:0] data_out;

	//Instantiate Modules
    pc pc(.clk(clk), .reset(reset), .data_in(data_in), .data_out(data_out));
    
	// Start running clock
	always begin
		#5 clk = ~clk;
	end

	initial begin
		// Initialise testbench
        clk = 0; reset = 0; data_in = 32'hFFFFFFFF;
        
        // Reset PC
        #10 reset = 1;
        #5 reset = 0;
        
		// Change value in PC
		#5 data_in = 32'h00000004;
		
		// Finish simulation
		#10 $finish;
	end
	
endmodule
