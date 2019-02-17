// Written by Jack McEllin - 15170144
// A testbench for testing the program counter

`include "storegen.vh"

module store_generator_tb;
	
	//Declare Registers and Wires
	reg [2:0] storesel;
    reg [31:0] source;
    wire [31:0] destination;

	//Instantiate Modules
    store_generator lg(.I_storesel(storesel), .I_data(source), .O_data(destination));    

	initial begin
		// Initialise testbench
        source = 32'h80808080; storesel= `STORE_SB;
		#10 $display("storesel=STORE_SB,  destination=%h", destination);
        
		// Change value in PC
		#10 storesel= `STORE_SH;
		#10 $display("storesel=STORE_SH,  destination=%h", destination);
		#10 storesel= `STORE_SW;
		#10 $display("storesel=STORE_SW,  destination=%h", destination);
		
		// Finish simulation
		#10 $finish;
	end
	
endmodule
