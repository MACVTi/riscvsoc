// Written by Jack McEllin - 15170144
// A program counter

module pc #(parameter RESET=32'h00000000) (
		input wire I_clk,
		input wire I_rst,
		input wire [31:0] I_address,
		output reg [31:0] O_address
	 );

always @(posedge I_clk) begin
<<<<<<< HEAD
    if(I_rst != 1) begin
=======
   	$display("The program counter is now %h", O_address);
    if(I_rst == 1) begin
	   O_address <= RESET;
	   $display("The program counter was reset");
    end
    else begin
>>>>>>> 420b17b134fc31c167256e60dd055f8462153fa8
	   O_address <= I_address;	
	end
end

always @(negedge I_rst) begin
	O_address <= RESET;	
end

endmodule
