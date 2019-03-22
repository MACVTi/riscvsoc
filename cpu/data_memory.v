// The test data memory module for the CPU
// Written by Jack McEllin - 15170144

module data_memory #(parameter MEMFILE="") (
	input wire I_clk,
	input wire I_memrw,
	input wire [31:0] I_address,
	input wire [31:0] I_data,
	output wire [31:0] O_data
	);

    // Declare some memory that we can use for data memory
	reg [7:0] memory [0:1023];
	integer i;

    // Connect output to memory
    assign O_data = {memory[I_address+3],memory[I_address+2],memory[I_address+1],memory[I_address]};

	initial begin
	   // Initialise the memory with zeros before loading instruction
	    $display("Initialising the data memory with zeros");
	    for (i=0; i<1024; i=i+1) begin
	        memory[i]= 8'h00;
        end
		if (MEMFILE > 0) begin
			$display("Loading initial data memory file: " + MEMFILE);
			$readmemh(MEMFILE, memory, 8'h00);
		end
		else begin
            $display("There was an error loading the data memory file!");
        end
	end

	always @ (posedge I_clk) begin
            if (I_memrw == 1'b1) begin
				{memory[I_address+3],memory[I_address+2],memory[I_address+1],memory[I_address]} <= I_data;
				$display("STORE | DATA:%h\tADDRESS:%h", I_data, I_address);
			end
			else begin
			    $display("LOAD | DATA:%h\tADDRESS:%h", O_data, I_address);
			end
    end  
    
endmodule
