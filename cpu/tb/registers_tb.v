// Written by Jack McEllin - 15170144
// A testbench for testing the registers of the CPU
module registers_tb;
	
	//Declare Registers and Wires
	reg clk;
	reg reset;
	reg regwen;
	reg [3:0] rs1;
	reg [3:0] rs2;
	reg [3:0] rd;
	reg [31:0] source;
	wire [31:0] destination_1;
	wire [31:0] destination_2;

	//Instantiate Modules
	registers register(
		.I_clk(clk),
		.I_rst(reset),
		.I_regwen(regwen),
		.I_rs1(rs1),
		.I_rs2(rs2),
		.I_rd(rd),
		.I_data(source),
		.O_data1(destination_1),
		.O_data2(destination_2)
	);

	// Start running clock
	always begin
		#5 clk = ~clk;
	end

	initial begin
		// Initialise testbench
		clk = 0; reset = 0; regwen = 0; rs1 = 0; rs2 = 0; rd = 0; source = 0;
        
        // Clear all registers
        #10 reset = 1;
        #10 reset = 0;
        
        $display("Check that registers were cleared");
        for (integer i = 0; i < 16; i=i+1) begin
            #10 regwen = 0; rs1 = i; rs2 = i; 
            #10 $display("Register1 = %h, Data1= %h, Register2 = %h, Data2= %h", rs1, destination_1, rs2, destination_2);
        end

		// Write test values to registers
		$display("\nWrite values to registers");
		for (integer i = 1; i < 16; i=i+1) begin
           #10 regwen = 1; rd = i; source = i;
           #10 regwen = 0;
           #10 $display("Register = %h, Data = %h", rd, source);
        end

		// Read test values from registers
		$display("\nCheck values from registers");
		for (integer i = 0; i < 16; i=i+1) begin
		  #10 regwen = 0; rs1 = i; rs2 = i; 
		  #10 $display("Register1 = %h, Data1= %h, Register2 = %h, Data2= %h", rs1, destination_1, rs2, destination_2);
	    end

		// Check that we can't write to register zero
		#10 $display("\nCheck that we can't write to x0");
		#10 regwen = 1; rd = 4'b0000; source = 32'h99999999;
		#10 $display("Register = %h, Data = %h", rd, source);
		#10 regwen = 0; rd = 4'b0000; source = 32'h00000000;
		#10 $display("Register = %h, Data = %h", rd, source);

		// Finish simulation
		#10 $finish;
	end
	
endmodule
