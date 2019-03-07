`timescale 1ns / 1ps

module top(
	input wire CLK1MHZ,
	input wire CPU_RESETN,
    input wire SW,
	
	// LED Connections
	output wire [15:0] LED,
	
	// Seven Segment Display Connections
	output wire CA,
	output wire CB,
	output wire CC,
	output wire CD,
	output wire CE,
	output wire CF,
	output wire CG,
	output wire DP,
    output wire [7:0] AN,
	
	// VGA Connections
	output wire VGA_HS,
	output wire VGA_VS,
	output wire [3:0] VGA_R,
	output wire [3:0] VGA_G,
	output wire [3:0] VGA_B
    );
    
	// Connect Reset to Button
	wire reset = ~CPU_RESETN;
	
	assign {CA,CB,CC,CD,CE,CF,CG,DP} = 8'h00;
	assign AN = 8'h00;
	
	wire O_data_memRW;
    wire [31:0] O_data_Addr_in;
    wire [31:0] O_data_Data_in;
    reg [31:0] I_data_Data_out;
    
    reg stb_led;
    reg stb_vga;
    reg stb_ram;
    
	//Instantiate CPU
    cpu #(
        .RESET(32'h00000000),
        .VECTOR(32'h00000010),
        .INSTRUCTION_MEM("led_test.mem")
    )
    riscv (
        .I_clk(CLK1MHZ),
        .I_rst(reset),
        .I_interrupt(1'b0),
        
        // Data memory connection wires
        .O_data_memRW(O_data_memRW),
        .O_data_Addr_in(O_data_Addr_in),
        .O_data_Data_in(O_data_Data_in),
        .I_data_Data_out(I_data_Data_out)
    );
    
    wire [31:0] ram_Data_out;
//     Instantiate 8k RAM module
    ram_wishbone ram (
        .CLK_I(CLK1MHZ),
        .RST_I(reset),
        .STB_I(stb_ram),
        .WE_I(O_data_memRW),
        .ADR_I(O_data_Addr_in),
        .DAT_I(O_data_Data_in),
        .DAT_O(ram_Data_out)
    );

    // Instantiate the LED module
    led_wishbone led (
        .CLK_I(CLK1MHZ),
        .RST_I(reset),
        .STB_I(stb_led),
        .WE_I(O_data_memRW),
        .DAT_I(O_data_Data_in),
        
        .O_led(LED)
    );
    
        // Instantiate the VGA module
    vga_wishbone #(
        .TEXT_DATA_MEMFILE("text.mem"),
        .TEXT_COLOUR_MEMFILE("text_colour.mem")    
    )
    vga (
        .CLK_I(CLK1MHZ),
        .RST_I(reset),
        .STB_I(stb_vga),
        .WE_I(O_data_memRW),
        .ADR_I(O_data_Addr_in),
        .DAT_I(O_data_Data_in),
        
        .mode(SW),
        .hsync(VGA_HS),
        .vsync(VGA_VS),
        .red(VGA_R),
        .green(VGA_G),
        .blue(VGA_B)            
    );


    // Create an arbriter to select the correct device depending on memory address
    always @(posedge CLK1MHZ) begin
        stb_led <= 0;
        stb_vga <= 0;
        stb_ram <= 0;
        I_data_Data_out <= 32'h00000000;

        casez(O_data_Addr_in)

            32'hFFFF0000: begin //0x00000000: LED
                stb_led <= 1;
                I_data_Data_out <= 32'hFFFFFFFF;
            end
            
            {16'hEEEE, 16'h????}: begin //0xEEEE0000 - EEEEFFFF: VGA
                stb_vga <= 1;
                I_data_Data_out <= 32'h00000000;
            end
            
            default: begin
                stb_ram <= 1;
                I_data_Data_out <= ram_Data_out;
            end
        endcase
    end
endmodule
