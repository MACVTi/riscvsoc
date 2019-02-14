module instruction_memory #(parameter MEMFILE="") (
	input wire clk,
	input wire [31:0] address,
	output reg busy,
	output reg [31:0] instruction
	);

	reg [31:0] memory [0:1024];
    
	initial begin
		if (MEMFILE > 0) begin
			$display("Loading initial data memory file: " + MEMFILE);
			$readmemb(MEMFILE, memory);
		end
	end

	always @ (posedge clk) begin
	   instruction <= memory[address];
	   //if(memory[address][1:0] != 2'b11) begin
	   //instruction <= memory[address] & 32'hFFFF0000;
	   //end
	   //else begin
	   //	  instruction <= memory[address];
	   //end
    end
endmodule
