// Written by Jack McEllin - 15170144
// A testbench for testing the branch comparator

module branch_comparator_tb;
	
	//Declare Registers and Wires
    reg	bun;
	reg signed [31:0] source_1;
	reg signed [31:0] source_2;
    wire beq;
    wire blt;
    
	//Instantiate Modules
	branch_comparator bc(.I_branch_unsigned(bun), .I_data1(source_1), .I_data2(source_2), .O_branch_equal(beq), .O_branch_lessthan(blt));

	initial begin
		// Initialise testbench
		source_1 = $signed(0); source_2 = $signed(0); bun = 0;
	
		// Check that equals works for both positive and negative numbers when bun = 0
		$display("bun = 0");
		#10 source_1 = $signed(1); source_2 = $signed(2);
        #10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
		#10 source_1 = $signed(2); source_2 = $signed(1);
        #10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
		#10 source_1 = $signed(1); source_2 = $signed(1);
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
		#10 source_1 = $signed(1); source_2 = $signed(0);
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
		#10 source_1 = $signed(0); source_2 = $signed(0);
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
        #10 source_1 = $signed(0); source_2 = $signed(-1);
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
        #10 source_1 = $signed(-1); source_2 = $signed(0);
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
        #10 source_1 = $signed(-1); source_2 = $signed(-1);
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
        #10 source_1 = $signed(-1); source_2 = $signed(-2);
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
        #10 source_1 = $signed(-2); source_2 = $signed(-1);
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
        #10 source_1 = $signed(-2); source_2 = $signed(-2);
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);

        // Check that equals works for both positive and negative numbers when bun = 1
        $display("\nbun = 1");
		#10 source_1 = $signed(1); source_2 = $signed(2); bun = 1;
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
		#10 source_1 = $signed(2); source_2 = $signed(1);
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
		#10 source_1 = $signed(1); source_2 = $signed(1);
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
		#10 source_1 = $signed(1); source_2 = $signed(0);
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
		#10 source_1 = $signed(0); source_2 = $signed(0);
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
        #10 source_1 = $signed(0); source_2 = $signed(-1);
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
        #10 source_1 = $signed(-1); source_2 = $signed(0);
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
        #10 source_1 = $signed(-1); source_2 = $signed(-1);
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
        #10 source_1 = $signed(-1); source_2 = $signed(-2);
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
        #10 source_1 = $signed(-2); source_2 = $signed(-1);
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);
        #10 source_1 = $signed(-2); source_2 = $signed(-2);
		#10 $display("source_1=%d, source2=%d, bun=%d | beq=%d, blt=%d", source_1, source_2, bun, beq, blt);

		// Finish simulation
		#10 $finish;
	end
	
endmodule
