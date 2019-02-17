module instruction_memory_tb;
	
	//Declare Registers and Wires
    reg clk;
    reg [31:0] address;
    wire [31:0] destination;

	//Instantiate instructio memory module
    instruction_memory #(
        .MEMFILE("first_test.mem")
    )
    inst_mem(
        .I_clk(clk),
        .I_address(address),
        .O_data(destination)
    );

	// Start running clock
	always begin
		#5 clk = ~clk;
	end

    initial begin
		// Initialise testbench
        clk = 1; address = 32'h00000000;
		
		$display("\nTesting reading of instruction memory");
		for (integer i = 0; i < 128; i=i+4) begin
            #10 address = i;
            #10 $display("Address = %h, Data = %h", address, destination);
        end
		
		// Finish simulation
		#10 $finish;
	end
	
endmodule
