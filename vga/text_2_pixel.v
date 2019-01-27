module text_to_pixel #(parameter TEXT_DATA_WIDTH=8, TEXT_COLOUR_WIDTH=8) (
	input wire clk,
	input wire [9:0] x,
	input wire [8:0] y,	
	input wire [TEXT_DATA_WIDTH-1:0] text_data,
	input wire [TEXT_COLOUR_WIDTH-1:0] text_colour,
	output reg [((TEXT_COLOUR_WIDTH/2)-1):0] pixel
    );
	// Load in our character map
	reg [63:0] character_map [0:255];

	initial begin
		$display("Loading character map");
		$readmemh("font.mem", character_map);
	end

	always @(posedge clk) begin
		if (character_map[text_data][((y%8)*8)+(x%8)] == 1) begin
			pixel <= text_colour[3:0];
		end
		else begin
			pixel <= text_colour[7:4];
		end	
	end

endmodule
