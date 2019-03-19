`timescale 1ns / 1ps

module top #(parameter DIV = 27'd100000)(
	input wire CLK100MHZ,
	input wire CPU_RESETN,
	input wire BTNC,
//    input wire SW,
	
	// LED Connections
	output wire [15:0] LED,
	
	// Seven Segment Display Connections
//	output wire CA,
//	output wire CB,
//	output wire CC,
//	output wire CD,
//	output wire CE,
//	output wire CF,
//	output wire CG,
//	output wire DP,
//    output wire [7:0] AN
	
	// VGA Connections
	output wire VGA_HS,
	output wire VGA_VS,
	output wire [3:0] VGA_R,
	output wire [3:0] VGA_G,
	output wire [3:0] VGA_B
    );
    
	// Connect Reset to Button
	wire reset = ~CPU_RESETN;
	wire SYS_CLK;
	
//	assign {CA,CB,CC,CD,CE,CF,CG,DP} = 8'h00;
//	assign AN = 8'hFF;
	
	// Wires to connect to CPU
	wire cpu_WE;
    wire [31:0] cpu_Addr_In;
    wire [31:0] cpu_Data_In;
    reg [31:0] cpu_Data_Out;

    // Data output for RAM module
    wire [31:0] ram_Data_out;
    
    // Wire for VGA interrupt
    wire vga_interrupt;
    
    //Device Select Wires
    reg stb_led;
    reg stb_vga;
    reg stb_ram;
    
    // Reduce SoC Clock-Rate to 25MHz
    clock_divider #(
        .DIVISOR(4)
    )
    divider (
        .I_clk(CLK100MHZ),
        .O_clk(SYS_CLK)
    );
    
	//Instantiate CPU
    cpu #(
        .RESET(32'h00000000),
        .VECTOR(32'h00000020),
        .INSTRUCTION_MEM("program.mem")
    )
    riscv (
        .CLK_I(SYS_CLK),
        .RST_I(reset),
        .INT_I(BTNC),
        
        // Data memory connection wires
        .WE_O(cpu_WE),
        .ADR_O(cpu_Addr_In),
        .DAT_O(cpu_Data_In),
        .DAT_I(cpu_Data_Out)
    );
    
    
    // Instantiate RAM module
    ram_wishbone ram (
        .CLK_I(SYS_CLK),
        .RST_I(reset),
        .STB_I(1'b1),
        .WE_I(cpu_WE),
        .ADR_I(cpu_Addr_In),
        .DAT_I(cpu_Data_In),
        .DAT_O(ram_Data_out)
    );

    // Instantiate the LED module
    led_wishbone led (
        .CLK_I(SYS_CLK),
        .RST_I(reset),
        .STB_I(stb_led),
        .WE_I(cpu_WE),
        .DAT_I(cpu_Data_In[15:0]),
        
        .O_led(LED)
    );
    
    // Instantiate the VGA module
    vga_wishbone #(
        .TEXT_DATA_MEMFILE("text.mem"),
        .TEXT_COLOUR_MEMFILE("text_colour.mem")    
    )
    vga (
        .CLK_I(SYS_CLK),
        .RST_I(reset),
        .STB_I(stb_vga),
        .WE_I(cpu_WE),
        .ADR_I(cpu_Addr_In),
        .DAT_I(cpu_Data_In),
        .INT_O(vga_interrupt),
        
        .mode(1'b0),
        .hsync(VGA_HS),
        .vsync(VGA_VS),
        .red(VGA_R),
        .green(VGA_G),
        .blue(VGA_B)            
    );

    // Use a bus arbriter to select the correct device depending on memory address
    always @(*) begin
        // Select neither device and set CPU data out to 0
        stb_led = 0;
        stb_vga = 0;
        stb_ram = 0;
        cpu_Data_Out = 32'h00000000;

        casez(cpu_Addr_In)

            32'hFFFF0000: begin //0xFFFF0000: LED
                stb_led = 1;
                $display("LED Selected: %h", cpu_Addr_In);
            end
            
            32'hAAAA????: begin //0xAAAA0000 - 0xAAAAFFFF
                stb_vga = 1;
                $display("VGA Selected: %h", cpu_Addr_In);
            end
            
            default: begin
                stb_ram = 1;
                $display("RAM Selected: %h", cpu_Addr_In);
                cpu_Data_Out = ram_Data_out;
            end
        endcase
    end
endmodule
