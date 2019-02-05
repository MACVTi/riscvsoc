module registers(
	input clk,
	input reset,
	input we,
	input re,
	input [3:0] rs1,
	input [3:0] rs2,
	input [3:0] rd,
	input [31:0] write_data,
	output reg [31:0] read_data_1,
	output reg [31:0] read_data_2
    );

	integer i;
	wire zero = 32'h00000000;
	reg [31:0] register [15:1];

	always @(posedge clk) begin
		if (reset) begin
			for (i=1; i <= 15; i=i+1) begin
				register[i] <= zero;
			end
			read_data_1 <= zero;
			read_data_2 <= zero;
		end

		if (we && (rd != 0)) begin
			register[rd] <= write_data;
		end
		
		if (re) begin	
			if (rs1 == 4'b0000) begin
				read_data_1 <= zero;
			end
			else begin
				read_data_1 <= register[rs1];
			end

			if (rs2 == 4'b0000) begin
				read_data_2 <= zero;
			end
			else begin
				read_data_2 <= register[rs2];
			end
		end
	end

endmodule
