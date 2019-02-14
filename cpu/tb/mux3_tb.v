// Written by Jack McEllin - 15170144
// A testbench for testing a two-input multiplexor

module mux3_tb;
	
	//Declare Registers and Wires
	reg clk;
	reg [1:0] sel;	
	reg [31:0] source_1;
	reg [31:0] source_2;
	reg [31:0] source_3;
	wire [31:0] out;

	//Instantiate Modules
	mux3 mux3(.sel(sel), .data_in1(source_1), .data_in2(source_2), .data_in3(source_3), .data_out(out));

	// Start running clock
	always begin
		#5 clk = ~clk;
	end

	initial begin
		// Initialise testbench
		clk = 1; sel = 2'b00; source_1 = 32'h00000001; source_2 = 32'h00000002; source_3 = 32'h00000003;
	
		// Change selected source
		#10 sel = 2'b01;
		
		// Change selected source
        #10 sel = 2'b10;
        
        // Change selected source
        #10 sel = 2'b11;
		
		// Finish simulation
		#10 $finish;
	end
	
endmodule
