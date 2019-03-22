// Written by Jack McEllin - 15170144
// A testbench for testing a three-input multiplexor

module mux_privilege_tb;
	
	//Declare Registers and Wires
	reg en;	
	reg sel;	
	reg [31:0] source_1;
	reg [31:0] source_2;
	reg [31:0] source_3;
	wire [31:0] destination;

	//Instantiate Modules
	mux_privilege mux_privilege(.I_en(en), .I_sel(sel), .I_data1(source_1), .I_data2(source_2), .I_data3(source_3), .O_data(destination));

	initial begin
		// Initialise testbench
		en = 0; sel = 0; source_1 = 32'h00000001; source_2 = 32'h00000002; source_3 = 32'h00000003;
	
		// Change selected source
		#10 sel = 1;
		
		// Change selected source
        #10 en = 1; sel = 0;
        
        // Change selected source
        #10 sel = 1;
		
		// Finish simulation
		#10 $finish;
	end
	
endmodule
