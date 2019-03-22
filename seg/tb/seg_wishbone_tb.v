// Written by Jack McEllin - 15170144
// A testbench for testing a two-input multiplexor

module seg_wishbone_tb;
	
	//Declare Registers and Wires
	reg clk;
	reg reset;	
	reg [31:0] source;
	reg chip_sel;
	reg wen;
	wire [31:0] destination;
	wire [6:0] cathode;
	wire [7:0] anode;

	//Instantiate Modules
	seg_wishbone seg(
        .CLK_I(clk),
        .RST_I(reset),
        .DAT_I(source),
        .STB_I(chip_sel),
        .WE_I(wen),
        .DAT_O(destination),
        
        // Nexys 4 DDR connection wires
        .O_cathode(cathode),    //DP is not connected
        .O_anode(anode)
    );

	// Start running clock
	always begin
		#500 clk = ~clk;
	end

	initial begin
		// Initialise testbench
		clk = 1; reset = 0; source = 32'h00000001; chip_sel = 0; wen = 0;
	
		// Change selected source
		#1000 reset = 1;
		#1000 reset = 0;
		
		// Finish simulation
		#20000000 $finish;
	end
	
endmodule
