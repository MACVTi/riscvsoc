// Written by Jack McEllin - 15170144
// A testbench for testing the program counter

module pc_tb;
	
	//Declare Registers and Wires
	reg clk;
	reg reset;
    reg [31:0] address_in;
    wire [31:0] address_out;

	//Instantiate Modules
    pc pc(.I_clk(clk), .I_rst(reset), .I_address(address_in), .O_address(address_out));
    
	// Start running clock
	always begin
		#5 clk = ~clk;
	end

	initial begin
		// Initialise testbench
        clk = 0; reset = 0; address_in = 32'hFFFFFFFF;
        
        // Reset PC
        #10 reset = 1;
        
        // Change value in PC
        #10 reset = 0; address_in = 32'h00000004;
	
		// Finish simulation
		#10 $finish;
	end
	
endmodule
