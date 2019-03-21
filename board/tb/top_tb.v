module top_tb;
	
	//Declare Registers and Wires
	reg CLK100MHZ;
	reg CPU_RESETN;

    reg interrupt;

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

    top #(
        .DIV(4)
    )
    top(
        .CLK100MHZ(CLK100MHZ),
        .CPU_RESETN(CPU_RESETN),
        .BTNC(interrupt),
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
		#5 CLK100MHZ = ~CLK100MHZ;
		if(CLK100MHZ == 1) begin
		  //$display("New Positive Clock Edge");
		end
	end

	initial begin
		// Initialise testbench
        CLK100MHZ = 1; CPU_RESETN = 0; 
        #40 CPU_RESETN = 1;
        
//        for(integer i = 0; i <= 1000; i = i + 1) begin
//            #2000 interrupt = 1;
//            #40 interrupt = 0;
//            #40 interrupt = 1;
//            #40 interrupt = 0;
//            #40 interrupt = 1;
//            #40 interrupt = 0;
//            #10000;
//        end 
//        $display("Testing External Interrupt");
//        #10 interrupt = 0;
		// Write test values to registers
		// Finish simulation
		#10000 $finish;
	end
	
endmodule
