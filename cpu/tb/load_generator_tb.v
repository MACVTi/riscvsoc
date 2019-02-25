// Written by Jack McEllin - 15170144
// A testbench for testing the program counter

`include "load_generator.vh"

module load_generator_tb;
	
	//Declare Registers and Wires
	reg [2:0] loadsel;
    reg [31:0] source;
    wire [31:0] destination;

	//Instantiate Modules
    load_generator load_gen(.I_loadsel(loadsel), .I_data(source), .O_data(destination));    

	initial begin
		// Initialise testbench
        source = 32'h80808080; loadsel= `LOAD_LB;
		#10 $display("loadsel=LOAD_LB,  destination=%h", destination);
        
		// Change value in PC
		#10 loadsel= `LOAD_LH;
		#10 $display("loadsel=LOAD_LH,  destination=%h", destination);
		#10 loadsel= `LOAD_LW;
		#10 $display("loadsel=LOAD_LW,  destination=%h", destination);
		#10 loadsel= `LOAD_LBU;
		#10 $display("loadsel=LOAD_LBU, destination=%h", destination);
		#10 loadsel= `LOAD_LHU;
		#10 $display("loadsel=LOAD_LHU, destination=%h", destination);
		
		// Finish simulation
		#10 $finish;
	end
	
endmodule
