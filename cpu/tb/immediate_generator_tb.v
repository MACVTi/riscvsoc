// Written by Jack McEllin - 15170144
// A testbench for testing the program counter

`include "immgen.vh"

module immediate_generator_tb;
	
	//Declare Registers and Wires
	reg [2:0] immsel;
    reg [31:0] source;
    wire [31:0] destination;

	//Instantiate Modules
    immediate_generator immediate_generator(.I_immsel(immsel), .I_data(source), .O_data(destination));    

	initial begin
		// Initialise testbench
        immsel = `IMM_ITYPE; source = 32'h00208463;
        $display("\t\t\t\t\tsource =\t\t%b", source);
        #10 $display("immsel=IMM_ITYPE,\tdestination=\t%b", destination);

        
		// Change value in PC
		#10 immsel = `IMM_STYPE;
		#10 $display("immsel=IMM_STYPE,\tdestination=\t%b", destination);
		#10 immsel = `IMM_BTYPE;
		#10 $display("immsel=IMM_BTYPE,\tdestination=\t%b", destination);
		#10 immsel = `IMM_UTYPE;
		#10 $display("immsel=IMM_UTYPE,\tdestination=\t%b", destination);
		#10 immsel = `IMM_JTYPE;
		#10 $display("immsel=IMM_JTYPE,\tdestination=\t%b", destination);

		// Finish simulation
		#10 $finish;
	end
	
endmodule
