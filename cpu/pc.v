// The program counter module for the CPU
// Written by Jack McEllin - 15170144

module pc #(parameter RESET=32'h00000000) (
		input wire I_clk,
		input wire I_rst,
		input wire [31:0] I_address,
		output reg [31:0] O_address
	 );

    always @(posedge I_clk) begin
        if(I_rst == 1) begin
           O_address <= RESET;
           $display("The program counter was reset");
        end
        else begin
           O_address <= I_address;	
        end
    end

endmodule
