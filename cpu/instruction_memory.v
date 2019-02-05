module instruction_memory #(parameter MEMFILE="") (
	input wire clk,
	input wire [31:0] address,
	output reg [31:0] instruction
	);

	reg [7:0] memory [0:1024];

	initial begin
		if (MEMFILE > 0) begin
			$display("Loading initial data memory file: " + MEMFILE);
			$readmemh(MEMFILE, memory);
		end
	end

	always @ (posedge clk) begin
	   if(memory[address][1:0] != 2'b11) begin
	      instruction <= {memory[address],memory[address+1],16'h0000};
	   end
	   else begin
		  instruction <= {memory[address],memory[address+1],memory[address+2],memory[address+3]};
	   end
    end
endmodule
