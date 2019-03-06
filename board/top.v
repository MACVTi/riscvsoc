`timescale 1ns / 1ps

module top(
	input wire CLK1MHZ,
	input wire CPU_RESETN,
    input wire SW,
	
	// LED Connections
	output wire [15:0] LED,
	
////	// Seven Segment Display Connections
//	output wire [7:0] disp_seg_o,
//    output wire [7:0] disp_an_o
	
//	// VGA Connections
	output wire VGA_HS,
	output wire VGA_VS,
	output wire [3:0] VGA_R,
	output wire [3:0] VGA_G,
	output wire [3:0] VGA_B
    );
    
	// Connect Reset to Button
	wire reset = ~CPU_RESETN;
	
////	assign disp_seg_o = 8'h00;
////	assign disp_an_o = 8'h00;
	
	wire O_data_memRW;
    wire [31:0] O_data_Addr_in;
    wire [31:0] O_data_Data_in;
    wire [31:0] I_data_Data_out;
//    wire [31:0] cpu_mem_Data_out;
    
    reg stb_led;
//    reg stb_vga;
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
        
//        // Data memory connection wires
        .O_data_memRW(O_data_memRW),
        .O_data_Addr_in(O_data_Addr_in),
        .O_data_Data_in(O_data_Data_in),
        .I_data_Data_out(I_data_Data_out)
//        .I_memData(cpu_mem_Data_out)
    );
    
    
    // Declare data memory
//    data_memory #(
//        .MEMFILE("")
//    )
//    data (
//        .I_clk(clk_i),
//        .I_memrw(cpu_mem_RW),
//        .I_address(cpu_mem_Addr_in),
//        .I_data(cpu_mem_Data_in),
//        .O_data(cpu_mem_Data_out)
//    );

    // Instantiate 8k RAM module
//    ram_wishbone ram (
//        .CLK_I(clk_i),
//        .STB_I(stb_ram),
//        .WE_I(cpu_mem_RW),
//        .ADR_I(cpu_mem_Addr_in),
//        .DAT_I(cpu_mem_Data_in),
//        .DAT_O(cpu_mem_Data_out)
//    );

//    // Instantiate the LED module
    led_wishbone led (
        .CLK_I(CLK1MHZ),
        .STB_I(stb_led),
        .WE_I(O_data_memRW),
        .DAT_I(O_data_Data_in),
        
        .O_led(LED)
    );
    
        // Instantiate the VGA module
    vga_wishbone #(
        .TEXTDATA("text.mem"),
        .TEXTCOLOUR("text_colour.mem")    
    )
    vga (
        .CLK_I(CLK1MHZ),
        .RST_I(reset),
        .STB_I(stb_vga),
        .WE_I(cpu_mem_RW),
        .ADR_I(cpu_mem_Addr_in),
        .DAT_I(cpu_mem_Data_in),
        
        .mode(SW),
        .hsync(VGA_HS),
        .vsync(VGA_VS),
        .red(VGA_R),
        .green(VGA_G),
        .blue(VGA_B)            
    );


//    // Create an arbriter to select the correct device depending on memory address
    always @(*) begin
        stb_led = 0;
//        stb_vga <= 0;
        stb_ram = 0;

        casez(O_data_Addr_in)

            {32'hFFFF0000}: begin //0x00000000: LED
                stb_led = 1;
            end
            
            {{16'hFFFF, 2'b00, {13{1'b?}}}}: begin //0xFFFF0000 - FFFF3FFF: VGA
                stb_vga <= 1;
            end
            
            default: begin
                stb_ram = 1;
            end
        endcase
    end

    // Instantiate 8k RAM module
//    ram_wishbone #(
//        .ADDRESS_WIDTH(32),
//        .DATA_WIDTH(32),
//        .DEPTH('h400)
//    )
//    ram (
//        .CLK_I(I_clk),
//        .STB_I(ram_stb),
//        .WE_I(I_memrw),
//        .ADR_I(I_address),
//        .DAT_I(I_data),
//        .DAT_O(O_data)
//    );



    // Instantiate the VGA module
//	vga_wishbone vga (
//		.CLK_I(clk_i),
//		.RST_I(reset),
//		.STB_I(sw_i[1]),
//		.WE_I(sw_i[1]),
//		.ADR_I({17'b00000000000000000,sw_i[15:14],9'b000000000,sw_i[13:10]}),
//		.DAT_I({24'h00000,sw_i[9:2]}),
//		.INT_O(),
		
//		.mode(sw_i[0]),
//		.hsync(vga_hs_o),
//		.vsync(vga_vs_o),
//		.red(vga_red_o),
//		.green(vga_green_o),
//		.blue(vga_blue_o)			
//	);

	endmodule