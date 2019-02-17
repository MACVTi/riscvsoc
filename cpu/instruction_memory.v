module instruction_memory #(parameter MEMFILE="") (
	input wire I_clk,
	input wire [31:0] I_address,
	output wire [31:0] O_data
	);

    // Declare some memory that we can use for instruction memory
	reg [7:0] memory [0:1023];

	initial begin
	    // Initialise the memory with zeros before loading instructions
	    for (integer i=0; i<1024; i=i+1) begin
            memory[i]= 8'h00;
        end
        
        // Load the memfile into instruction memory, starting at address 0
		if (MEMFILE > 0) begin
			$display("Loading initial instruction memory file: " + MEMFILE);
			$readmemh(MEMFILE, memory, 8'h00);
		end
		else begin
		    $display("There was an error loading the instruction memory file!");
		end
	end

    assign O_data =  {memory[I_address+3],memory[I_address+2],memory[I_address+1],memory[I_address]};

endmodule
