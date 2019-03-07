module vga_wishbone #(parameter TEXT_DATA_MEMFILE="", TEXT_COLOUR_MEMFILE="")
    (
	// Wishbone Bus Connections
	input wire CLK_I,
	input wire RST_I,
	input wire [31:0] ADR_I,
	input wire [31:0] DAT_I,
	input wire STB_I,
	input wire WE_I,

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

//	reg [TEXT_ADDRESS_WIDTH-1:0] text_data_address;
//	reg [TEXT_ADDRESS_WIDTH-1:0] text_colour_address;
	reg [TEXT_DATA_WIDTH-1:0] text_data_out;
	reg [TEXT_COLOUR_WIDTH-1:0] text_colour_out;
	wire [3:0] pixel_out;

	// Allocate memory to store text data and colour information
	reg [TEXT_DATA_WIDTH-1:0] text_data_memory [0:TEXT_DATA_DEPTH-1];
	reg [TEXT_COLOUR_WIDTH-1:0] text_colour_memory [0:TEXT_COLOUR_DEPTH-1];

    integer i;
	initial begin
	    for (i=0; i < TEXT_DATA_DEPTH; i=i+1) begin
            text_data_memory[i]= 8'h00;
        end
        
        for (i=0; i < TEXT_COLOUR_DEPTH; i=i+1) begin
            text_colour_memory[i]= 8'h40;
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
		$display("Loading VGA colour palette");
		$readmemh("vga_colour_palette.mem", palette);
	end


	// Draw out image to the screen
	always @ (posedge CLK_I) begin
		// Draw current pixel
		text_data_out <= text_data_memory[((y>>3) * TEXT_WIDTH) + (x>>3)];
		text_colour_out <= text_colour_memory[((y>>3) * TEXT_WIDTH) + (x>>3)];

		if (active) begin
			colour <= palette[pixel_out];
		end
		else begin
			colour <= 0;
		end

		red <= colour[11:8];
		green <= colour[7:4];
		blue <= colour[3:0];

		// Write data to sram if both chip select and write enable are high
		if (STB_I) begin
			if (WE_I) begin
				casez(ADR_I[15:0])
					15'b0??????????????: begin
						text_data_memory[ADR_I[12:0]] <= DAT_I;
					end	

					15'b1??????????????: begin
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
