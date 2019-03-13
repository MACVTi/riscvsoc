`timescale 1ns / 1ps

module seg_top(
	input wire CLK100MHZ,
	input wire CPU_RESETN,
	
	// LED Connections
//	output wire [15:0] LED,
	
	// Seven Segment Display Connections
	output wire CA,
	output wire CB,
	output wire CC,
	output wire CD,
	output wire CE,
	output wire CF,
	output wire CG,
	output wire DP,
    output wire [7:0] AN
	
	// VGA Connections
//	output wire VGA_HS,
//	output wire VGA_VS,
//	output wire [3:0] VGA_R,
//	output wire [3:0] VGA_G,
//	output wire [3:0] VGA_B
    );
    
	// Connect Reset to Button
	wire reset = ~CPU_RESETN;
	
	assign DP = 1'b1;
	
    seg_wishbone seg (
        // Wishbone Bus Connections
        .CLK_I(CLK100MHZ),
        .RST_I(reset),
        
        // Nexys 4 DDR connection wires
        .O_cathode({CA,CB,CC,CD,CE,CF,CG}),    //DP is not connected
        .O_anode(AN)
    );

endmodule
