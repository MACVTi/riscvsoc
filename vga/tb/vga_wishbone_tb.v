// Written by Jack McEllin - 15170144
// A testbench for testing a two-input multiplexor

module vga_wishbone_tb;
    reg clk;
    reg rst;
    
    reg write_enable;
    reg [31:0] address;
    reg [31:0] data;
    
    wire interrupt;
    
    wire hsync;
    wire vsync;
    wire [3:0] red;
    wire [3:0] green;
    wire [3:0] blue;

	//Instantiate Modules
    vga_wishbone vga(
        // Wishbone Bus Connections
        .CLK_I(clk),
        .RST_I(rst),
        .STB_I(1'b1),
        .WE_I(write_enable),
        .ADR_I(address),
        .DAT_I(data),
        .INT_O(interrupt),
    
        // VGA Connections
        .mode(1'b0),
        .hsync(hsync),
        .vsync(vsync),
        .red(red),
        .green(green),
        .blue(blue)
    );

	// Start running clock
	always begin
		#20 clk = ~clk;
	end

	initial begin
		// Initialise testbench
		clk = 0; rst = 1;
		address = 32'h00000000; data = 32'h00000000; write_enable = 0; 

        #40 rst = 0;
        #40 address = 32'h00002580; data = 32'h00000001; write_enable = 1;
        #40 address = 32'h00000000; data = 32'h00000000; write_enable = 0;  
        
        #15412000 address = 32'h00002582; data = 32'h00000001; write_enable = 1;
        #40 address = 32'h00000000; data = 32'h00000000; write_enable = 0;   
        $monitor(interrupt);
        
		// Finish simulation
		#51000000 $finish;
	end
	
endmodule
