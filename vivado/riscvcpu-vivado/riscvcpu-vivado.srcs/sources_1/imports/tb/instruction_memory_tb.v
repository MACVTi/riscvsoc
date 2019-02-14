module instruction_memory_tb;
	
	//Declare Registers and Wires
    reg clk;
    reg [31:0] address;
    wire busy;
    wire [31:0] instruction;

	 // Declare instruction memory
       instruction_memory #(
       .MEMFILE("ctest_c.bin")
       )
       instruction_memory(
               .clk(clk), 
               .address(address),
               .busy(busy),
               .instruction(instruction)
       );
       
	// Start running clock
	always begin
		#10 clk = ~clk;
	end

	initial begin
		// Initialise testbench
		clk = 0; address = 32'h00000000;
        
        #20 address = 32'h00000004;
        #20 address = 32'h00000008;
        #20 address = 32'h0000000B;
        #20 address = 32'h00000010;
        #20 address = 32'h00000014;
        #20 address = 32'h00000018;
		// Write test values to registers
		// Finish simulation
		#20 $finish;
	end
	
endmodule
