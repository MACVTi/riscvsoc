`timescale 1ns / 1ps

module vga(
    input wire clk,
    input wire pixel_strobe,
    input wire reset,
    input wire mode,
    output wire hsync,
    output wire vsync,
    output wire blanking,
    output wire active,
    output wire screenend,
    output wire animate,
    output wire [9:0] x,
    output wire [8:0] y
    );

	// Define Parameters
	localparam HSYNC_START = 16;
	localparam HSYNC_END = 16 + 96;
	localparam HSYNC_ACTIVE = 16 + 96 + 48;

	localparam VSYNC_START = 480 + 11;
	localparam VSYNC_END = 480 + 11 + 2;
	localparam VSYNC_ACTIVE = 480;

	localparam LINE = 800;
	localparam SCREEN = 524;

	// Register to Store Position on Screen
	reg [9:0] h_count;
	reg [9:0] v_count;

	// Generate the Sync Signals
	assign hsync = ~((h_count >= HSYNC_START) & (h_count < HSYNC_END));
	assign vsync = ~((v_count >= VSYNC_START) & (v_count < VSYNC_END));

	// Keep x and y Within the Screen Limits
	assign x = (h_count < HSYNC_ACTIVE) ? 0 : (h_count - HSYNC_ACTIVE) >> mode;
	assign y = (v_count >= VSYNC_ACTIVE) ? (VSYNC_ACTIVE - 1): (v_count) >> mode;

	// Keep Blanking High Within the Blanking Period
	assign blanking = ((h_count < HSYNC_ACTIVE) | (v_count > VSYNC_ACTIVE - 1));

	// Keep Active High Within the Active Period
	assign active = ~((h_count < HSYNC_ACTIVE) | (v_count > VSYNC_ACTIVE - 1));

	// Set Screenend High for One Tick at the End of the Screen
	assign screenend = ((v_count == SCREEN - 1) & (h_count == LINE));

	// Set Animate High for One Tick at the End of the Final Pixel Line
	assign animate = ((v_count == VSYNC_ACTIVE - 1) & (h_count == LINE));

	//Draw Pixels
	always @ (posedge clk) begin
		if (reset) begin
			h_count <= 0;
			v_count <= 0;
		end
		if (pixel_strobe) begin
			if (h_count == LINE) begin
				h_count <= 0;
				v_count <= v_count + 1;
			end
			else begin
				h_count <= h_count + 1;
			end
			if (v_count == SCREEN) begin
				v_count <= 0;
			end
		end
	end
endmodule
