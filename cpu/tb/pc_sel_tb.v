// Written by Jack McEllin - 15170144
// A testbench for testing a three-input multiplexor

module pc_sel_tb;
	
	//Declare Registers and Wires
	reg clk;
	reg interrupt;
	reg [31:0] trap;
	reg [31:0] source;
	wire [31:0] destination;

	//Instantiate Modules
	pc_sel pcsel(.I_clk(clk), .I_interrupt(interrupt), .I_mtvec(trap), .I_data(source), .O_data(destination));

	// Start running clock
	always begin
		#5 clk = ~clk;
	end

	initial begin
		// Initialise testbench
		clk = 1; interrupt = 0; trap = 32'h0000000f; source = 32'h00000001;
	
		// Change selected source
		#10 source = 32'h00000002;
		#10 source = 32'h00000003; interrupt = 1; 
		#10 source = 32'h00000004;
		#10 interrupt = 0;
		#10 source = 32'h00000005;
		#10 source = 32'h00000006;
        #10 interrupt = 1;
        #10 source = 32'h00000007;
        #10 source = 32'h00000008;
		
		// Finish simulation
		#10 $finish;
	end
	
endmodule
