// Written by Jack McEllin - 15170144
// A program counter

module pc(
		input wire clk,
		input wire reset,
		input wire [31:0] data_in,
		output reg [31:0] data_out
	 );

always @(negedge clk) begin
    if(reset == 1) begin
	   data_out <= 32'h00000000;	    
    end
    else begin
	   data_out <= data_in;	
    end
end

endmodule
