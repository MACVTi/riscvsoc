module data_memory #(parameter MEMFILE="") (
	input wire I_clk,
	input wire I_memrw,
	input wire [31:0] I_address,
	input wire [31:0] I_data,
	output reg [31:0] O_data
	);

    // Declare some memory that we can use for data memory
	reg [31:0] memory [0:255];

	initial begin
		if (MEMFILE > 0) begin
			$display("Loading initial data memory file: " + MEMFILE);
			$readmemh(MEMFILE, memory);
		end
	end

	always @ (posedge I_clk) begin
			if (I_memrw) begin
				memory[I_address] <= I_data;
			end
			else begin
				O_data <= memory[I_address];
			end
    end
endmodule
