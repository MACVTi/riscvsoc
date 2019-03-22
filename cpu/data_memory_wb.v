// The test Wishbone Bus data memory module for the CPU
// Written by Jack McEllin - 15170144

module data_memory_wb #(parameter MEMFILE="") (
	input wire I_clk,
	input wire I_memrw,
	input wire [31:0] I_address,
	input wire [31:0] I_data,
	output reg [31:0] O_data
	);

    reg [2:0] device_select;
    wire [31:0] ram_data_out;

    wire na;

    ram_wishbone #(
        .ADDRESS_WIDTH(32),
        .DATA_WIDTH(32),
        .DEPTH(1024)
    )
    ram (
        .CLK_I(I_clk),
        .STB_I(device_select[0]),
        .WE_I(I_memrw),
        .ADR_I(I_address),
        .DAT_I(I_data),
        .DAT_O(ram_data_out),
        .ACK_O(na)
    );
    
    // Use abritrer to select correct device to write memory to
    always @(posedge I_clk) begin
        casez(I_address)
            32'h0000????:   begin                       //)x00000000 -> 0x0000FFFF
                                device_select[0] = 1'b1;
                                // Attach ram output to data memory output
                                O_data <= ram_data_out;
                            end
            default:        begin
                                device_select[0] = 1'b0;
                            end    
        endcase
    end
    
endmodule
