module register_tb;
	
	//Declare Registers and Wires
	reg clk;
	reg reset;
	reg we;
	reg re;
	reg [3:0] rs1;
	reg [3:0] rs2;
	reg [3:0] rd;
	reg [31:0] write_data;
	wire [31:0] read_data_1;
	wire [31:0] read_data_2;

	//Instantiate Modules
	registers register(
		.clk(clk),
		.reset(reset),
		.we(we),
		.re(re),
		.rs1(rs1),
		.rs2(rs2),
		.rd(rd),
		.write_data(write_data),
		.read_data_1(read_data_1),
		.read_data_2(read_data_2)
	);

	// Start running clock
	always begin
		#10 clk = ~clk;
	end

	initial begin
		// Initialise testbench
		clk = 0; reset = 0; we = 0; re = 0; rs1 = 0; rs2 = 0; rd = 0; write_data = 0;

		// Write test values to registers
		#10 we = 1; rd = 4'b0001; write_data = 32'h00000001;
		#10 we = 0; rd = 4'b0000; write_data = 32'h00000000;
		#10 we = 1; rd = 4'b0010; write_data = 32'h00000002;
		#10 we = 0; rd = 4'b0000; write_data = 32'h00000000;
		#10 we = 1; rd = 4'b0011; write_data = 32'h00000003;
		#10 we = 0; rd = 4'b0000; write_data = 32'h00000000;
		#10 we = 1; rd = 4'b0100; write_data = 32'h00000004;
		#10 we = 0; rd = 4'b0000; write_data = 32'h00000000;
		#10 we = 1; rd = 4'b0101; write_data = 32'h00000005;
		#10 we = 0; rd = 4'b0000; write_data = 32'h00000000;
		#10 we = 1; rd = 4'b0110; write_data = 32'h00000006;
		#10 we = 0; rd = 4'b0000; write_data = 32'h00000000;
		#10 we = 1; rd = 4'b0111; write_data = 32'h00000007;
		#10 we = 0; rd = 4'b0000; write_data = 32'h00000000;
		#10 we = 1; rd = 4'b1000; write_data = 32'h00000008;
		#10 we = 0; rd = 4'b0000; write_data = 32'h00000000;
		#10 we = 1; rd = 4'b1001; write_data = 32'h00000009;
		#10 we = 0; rd = 4'b0000; write_data = 32'h00000000;
		#10 we = 1; rd = 4'b1010; write_data = 32'h0000000A;
		#10 we = 0; rd = 4'b0000; write_data = 32'h00000000;
		#10 we = 1; rd = 4'b1011; write_data = 32'h0000000B;
		#10 we = 0; rd = 4'b0000; write_data = 32'h00000000;
		#10 we = 1; rd = 4'b1100; write_data = 32'h0000000C;
		#10 we = 0; rd = 4'b0000; write_data = 32'h00000000;
		#10 we = 1; rd = 4'b1101; write_data = 32'h0000000D;
		#10 we = 0; rd = 4'b0000; write_data = 32'h00000000;
		#10 we = 1; rd = 4'b1110; write_data = 32'h0000000E;
		#10 we = 0; rd = 4'b0000; write_data = 32'h00000000;
		#10 we = 1; rd = 4'b1111; write_data = 32'h0000000F;
		#10 we = 0; rd = 4'b0000; write_data = 32'h00000000;

		// Read test values from registers
		#10 re = 1; rs1 = 4'b0000; rs2 = 4'b0001;
		#10 re = 0;
		#10 re = 1; rs1 = 4'b0010; rs2 = 4'b0011;
		#10 re = 0;
		#10 re = 1; rs1 = 4'b0100; rs2 = 4'b0101;
		#10 re = 0;
		#10 re = 1; rs1 = 4'b0110; rs2 = 4'b0111;
		#10 re = 0;
		#10 re = 1; rs1 = 4'b1000; rs2 = 4'b1001;
		#10 re = 0;
		#10 re = 1; rs1 = 4'b1010; rs2 = 4'b1011;
		#10 re = 0;
		#10 re = 1; rs1 = 4'b1100; rs2 = 4'b1101;
		#10 re = 0;
		#10 re = 1; rs1 = 4'b1110; rs2 = 4'b1111;
		#10 re = 0;

		// Check that we can't write to register zero
		#10 we = 1; rd = 4'b0000; write_data = 32'h99999999;
		#10 we = 0; rd = 4'b0000; write_data = 32'h00000000;
		#10 re = 1; rs1 = 4'b0000; rs2 = 4'b0010;
		#10 re = 0;

		// Check reset
		#10 reset  = 1;
		#10 reset  = 0;

		// Read test values from registers
		#10 re = 1; rs1 = 4'b0000; rs2 = 4'b0001;
		#10 re = 0;
		#10 re = 1; rs1 = 4'b0010; rs2 = 4'b0011;
		#10 re = 0;
		#10 re = 1; rs1 = 4'b0100; rs2 = 4'b0101;
		#10 re = 0;
		#10 re = 1; rs1 = 4'b0110; rs2 = 4'b0111;
		#10 re = 0;
		#10 re = 1; rs1 = 4'b1000; rs2 = 4'b1001;
		#10 re = 0;
		#10 re = 1; rs1 = 4'b1010; rs2 = 4'b1011;
		#10 re = 0;
		#10 re = 1; rs1 = 4'b1100; rs2 = 4'b1101;
		#10 re = 0;
		#10 re = 1; rs1 = 4'b1110; rs2 = 4'b1111;
		#10 re = 0;

		// Finish simulation
		#10 $finish;
	end
	
endmodule
