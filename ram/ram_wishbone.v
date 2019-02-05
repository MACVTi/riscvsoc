module ram_wishbone #(parameter ADDRESS_WIDTH=8, DATA_WIDTH=8, DEPTH=256, MEMFILE="") (
	input wire CLK_I,
	input wire STB_I,
	input wire WE_I,
	input wire [ADDRESS_WIDTH-1:0] ADR_I,
	input wire [DATA_WIDTH-1:0] DAT_I,
	output reg [DATA_WIDTH-1:0] DAT_O,
	output reg ACK_O
	);

	reg [DATA_WIDTH-1:0] memory [0:DEPTH-1];

	initial begin
		if (MEMFILE > 0) begin
			$display("Loading initial memory file: " + MEMFILE);
			$readmemh(MEMFILE, memory);
		end
	end

	always @ (posedge CLK_I) begin
		if (STB_I) begin
			if (WE_I) begin
				memory[ADR_I] <= DAT_I;
			end
			else begin
				DAT_O <= memory[ADR_I];
			end
		end
		ACK_O <= STB_I;
	end
endmodule
