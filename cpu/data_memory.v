module data_memory #(parameter MEMFILE="") (
	input wire clk,
	input wire memwrite,
	input wire memread,
	input wire [31:0] address,
	input wire [31:0] writedata,
	output reg [31:0] readdata
	);

	reg [31:0] memory [0:256];

	initial begin
		if (MEMFILE > 0) begin
			$display("Loading initial data memory file: " + MEMFILE);
			$readmemh(MEMFILE, memory);
		end
	end

	always @ (posedge clk) begin
			if (memwrite) begin
				memory[address] <= writedata;
			end
			else begin
				readdata <= memory[address];
			end
    end
endmodule
