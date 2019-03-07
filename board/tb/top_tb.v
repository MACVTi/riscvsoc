module top_tb;
	
	//Declare Registers and Wires
	reg CLK1MHZ;
	reg CPU_RESETN;

    // LED Connections
    wire [15:0] LED;
        
    // Seven Segment Display Connections
//    wire CA;
//    wire CB;
//    wire CC;
//    wire CD;
//    wire CE;
//    wire CF;
//    wire CG;
//    wire DP;
//    wire [7:0] AN;
        
//     // VGA Connections
//     wire VGA_HS;
//     wire VGA_VS;
//     wire [3:0] VGA_R;
//     wire [3:0] VGA_G;
//     wire [3:0] VGA_B;

    top top(
        .CLK1MHZ(CLK1MHZ),
        .CPU_RESETN(CPU_RESETN),
        
        // LED Connections
        .LED(LED)
        
        // Seven Segment Display Connections
//        .CA(CA),
//        .CB(CB),
//        .CC(CC),
//        .CD(CD),
//        .CE(CE),
//        .CF(CF),
//        .CG(CG),
//        .DP(DP),
        
//        .VGA_HS(VGA_HS),
//        .VGA_VS(VGA_VS),
//        .VGA_R(VGA_R),
//        .VGA_G(VGA_G),
//        .VGA_B(VGA_B)
    );

	// Start running clock
	always begin
		#500 CLK1MHZ = ~CLK1MHZ;
		if(CLK1MHZ == 1) begin
		  //$display("New Positive Clock Edge");
		end
	end

	initial begin
		// Initialise testbench
        CLK1MHZ = 1; CPU_RESETN = 0;
        
        #1000000 CPU_RESETN = 1;
//        #100 interrupt = 1;
//        $display("Testing External Interrupt");
//        #10 interrupt = 0;
		// Write test values to registers
		// Finish simulation
		#1000000 $finish;
	end
	
endmodule
