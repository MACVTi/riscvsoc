module vga_wishbone(
	// Wishbone Bus Connections
	input wire CLK_I,
	input wire RST_I,
	input wire [14:0] ADR_I,
	input wire [7:0] DAT_I,
	input wire STB_I,
	input wire WE_I,
	output reg ACK_0,
	output reg [7:0] DAT_O,

	// VGA Connections
	input wire mode,
	output wire hsync,
	output wire vsync,
	output reg [3:0] red,
	output reg [3:0] green,
	output reg [3:0] blue
    );
    
	// Generate a 25Mhz pixel strobe
	reg [15:0] count;
	reg pixel_strobe;
	always @ (posedge CLK_I) begin
		{pixel_strobe, count} <= count + 16'h4000; // Divide by 4
	end

	// Wires to connect to x and y
	wire [9:0] x;
	wire [8:0] y;

	// Wire to know when the screen is being drawn to
	wire active;

	// Instantiate VGA module to generate 640x480 signal
	vga_generator display_vga(
		.clk(CLK_I),
		.pixel_strobe(pixel_strobe),
		.reset(RST_I),
		.mode(mode),
		.hsync(hsync),
		.vsync(vsync),
		.x(x),
		.y(y),
		.active(active)
	);

	// Parameters to calculate VRAM depth and width
	localparam SCREEN_WIDTH = 640;
	localparam SCREEN_HEIGHT = 480;
	localparam TEXT_WIDTH = SCREEN_WIDTH / 8;
	localparam TEXT_HEIGHT = SCREEN_HEIGHT / 8;
	localparam TEXT_ADDRESS_WIDTH = 13;
	localparam TEXT_DATA_DEPTH = TEXT_WIDTH * TEXT_HEIGHT;
	localparam TEXT_DATA_WIDTH = 8;
	localparam TEXT_COLOUR_DEPTH = TEXT_WIDTH * TEXT_HEIGHT;
	localparam TEXT_COLOUR_WIDTH = 8;
	localparam TEXT_DATA_MEMFILE = "text.mem";
	localparam TEXT_COLOUR_MEMFILE = "text_colour.mem";

	reg [TEXT_ADDRESS_WIDTH-1:0] text_data_address;
	reg [TEXT_ADDRESS_WIDTH-1:0] text_colour_address;
	reg [TEXT_DATA_WIDTH-1:0] text_data_out;
	reg [TEXT_COLOUR_WIDTH-1:0] text_colour_out;
	wire [3:0] pixel_out;

	// Allocate memory to store text data and colour information
	reg [TEXT_DATA_WIDTH-1:0] text_data_memory [0:TEXT_DATA_DEPTH-1];
	reg [TEXT_COLOUR_WIDTH-1:0] text_colour_memory [0:TEXT_COLOUR_DEPTH-1];

	initial begin
		if (TEXT_DATA_MEMFILE > 0) begin
			$display("Loading initial text data memory file: " + TEXT_DATA_MEMFILE);
			$readmemh(TEXT_DATA_MEMFILE, text_data_memory);
		end

		if (TEXT_COLOUR_MEMFILE > 0) begin
			$display("Loading initial text colour memory file: " + TEXT_COLOUR_MEMFILE);
			$readmemh(TEXT_COLOUR_MEMFILE, text_colour_memory);
		end
	end

	// Instantiate Text to Pixel to convert text information into pixel
	text_to_pixel #(
		.TEXT_DATA_WIDTH(TEXT_DATA_WIDTH),
		.TEXT_COLOUR_WIDTH(TEXT_COLOUR_WIDTH)
	)
	texttopixel (
	.clk(CLK_I),
	.x(x),
	.y(y),
	.text_data(text_data_out),
	.text_colour(text_colour_out),
	.pixel(pixel_out)
	);

	// Load in our palette
	reg [11:0] palette [0:15];
	reg [11:0] colour;

	initial begin
		$display("Loading palette");
		$readmemh("colour_palette.mem", palette);
	end


	// Draw out image to the screen
	always @ (posedge CLK_I) begin
		// Draw current pixel
		text_data_address <= ((y>>3) * TEXT_WIDTH) + (x>>3);
		text_colour_address <= ((y>>3) * TEXT_WIDTH) + (x>>3);

		text_data_out <= text_data_memory[text_data_address];
		text_colour_out <= text_colour_memory[text_colour_address];

		if (active) begin
			colour <= palette[pixel_out];
		end
		else begin
			colour <= 0;
		end

		red <= colour[11:8];
		green <= colour[7:4];
		blue <= colour[3:0];

		// Write data to sram if both strobe and write enable are high
		if (STB_I) begin
			if (WE_I) begin
				casez(ADR_I)
					15'b01?????????????: begin
						text_data_memory[ADR_I[12:0]] <= DAT_I;
					end	

					15'b10?????????????: begin
						text_colour_memory[ADR_I[12:0]] <= DAT_I;
					end	

					default: begin
						text_colour_memory[ADR_I[12:0]] <= DAT_I;
					end	
				endcase
			end
		end
	end
endmodule
