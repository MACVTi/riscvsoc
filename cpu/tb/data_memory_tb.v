module data_memory_tb;
	
	//Declare Registers and Wires
    reg clk;
    reg memrw;
    reg [31:0] address;
    reg [31:0] source;
    wire [31:0] destination;

	//Instantiate instructio memory module
    data_memory #(
        .MEMFILE("data.mem")
    )
    data_mem(
        .I_clk(clk),
        .I_memrw(memrw),
        .I_address(address),
        .I_data(source),
        .O_data(destination)
    );

	// Start running clock
	always begin
		#5 clk = ~clk;
	end

    initial begin
		// Initialise testbench
        clk = 1; address = 0; memrw = 0; source = 32'h00000001;
		
		$display("Initialized data memory");
		// Check that data initializes with zero values
		for (integer i = 0; i < 32; i=i+1) begin
            #10 address = i;
            #10 $display("Address = %h, Data = %h", address, destination);
        end
        
        $display("\nTesting reading and writing of data memory");
        // Write data
        #10 memrw = 1;
        for (integer i = 0; i < 32; i=i+1) begin
            #10 address = i; source = i;
        end
        
        // Check data wrote correctly
        #10 memrw = 0;
       	for (integer i = 0; i < 32; i=i+1) begin
            #10 address = i;
            #10 $display("Address = %h, Data = %h", address, destination);
        end
		
		// Finish simulation
		#10 $finish;
	end
	
endmodule
