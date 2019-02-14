module instruction_memory #(parameter MEMFILE="") (
	input wire I_clk,
	input wire [31:0] I_address,
	output reg [31:0] O_data
	);

    // Declare some memory that we can use for instruction memory
	reg [31:0] memory [0:255];

	initial begin
		if (MEMFILE > 0) begin
			$display("Loading initial instruction memory file: " + MEMFILE);
			$fread(MEMFILE, memory);
		end
	end

	always @ (posedge I_clk) begin
	   O_data <= {memory[I_address],memory[I_address+1],memory[I_address+2],memory[I_address+3]};
    end
endmodule
