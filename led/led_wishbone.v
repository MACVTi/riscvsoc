// Written by Jack McEllin - 15170144
// A flexible wishbone bus compatible ram module

module led_wishbone (
	input wire CLK_I,
	input wire RST_I,
	input wire STB_I,
	input wire WE_I,
	input wire [31:0] DAT_I,
	output reg [15:0] O_led
	);

    integer i;

	initial begin
		// Turn off all leds at startup
        O_led = 16'h0000;
	end

	always @ (posedge CLK_I) begin
        if (RST_I) begin
            O_led <= 16'h0000;
        end
		if (STB_I) begin
			if (WE_I) begin
                O_led <= DAT_I[15:0];
			end
		end
	end
endmodule
