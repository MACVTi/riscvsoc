// Written by Jack McEllin - 15170144
// A testbench for testing the decoder for compressed instructions

module decode_tb;
	
	//Declare Registers and Wires
    reg clk; 
    reg [31:0] source_1;
    wire [31:0] pc_increment;
    wire [31:0] destination;

	//Instantiate Modules
    decode decode(.I_clk(clk), .I_data(source_1), .O_pcincr(pc_increment), .O_data(destination));

	// Start running clock
	always begin
		#10 clk = ~clk;
	end

	initial begin
		// Initialise testbench
		clk = 1; source_1 = 32'h00000000;
		
		#10 source_1 = 32'h00000001;
		#10 source_1 = 32'h00000002;

		// Write test values to registers
		// Finish simulation
		#10 $finish;
	end
	
endmodule
