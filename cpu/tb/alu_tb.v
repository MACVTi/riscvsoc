`include "alu.vh"

module alu_tb;
	
	//Declare Registers and Wires
    reg [3:0] sel;
    reg signed [31:0] source_1;
    reg signed [31:0] source_2;
    wire signed [31:0] destination;
    
	//Instantiate Modules
    alu alu(.ALUSel(sel), .I_data1(source_1), .I_data2(source_2), .O_data(destination));
	
	task test_alu;
	   input signed [31:0] a;
	   input signed [31:0] b;
	   begin
	   
	   source_1 = a;
	   source_2 = b;
	   
	   sel = `ALU_ADD;
       #10 $display("ADD: \t%d \t+ \t%d \t= \t%d", source_1, source_2, destination);
            
       #10 sel = `ALU_SUB;
       #10 $display("SUB: \t%d \t- \t%d \t= \t%d", source_1, source_2, destination);
       #10 sel = `ALU_SLL;
       #10 $display("SLL: \t%d \t<< \t%d \t= \t%d", source_1, source_2, destination);
       #10 sel = `ALU_SLT;
       #10 $display("SLT: \t%d \t< \t%d \t= \t%d", source_1, source_2, destination);
       #10 sel = `ALU_SLTU;
       #10 $display("SLTU: \t%d \t< \t%d \t= \t%d", source_1, source_2, destination);
       #10 sel = `ALU_XOR;
       #10 $display("XOR: \t%d \t^ \t%d \t= \t%d", source_1, source_2, destination);
       #10 sel = `ALU_SRL;
       #10 $display("SRL: \t%d \t>> \t%d \t= \t%d", source_1, source_2, $signed(destination));
       #10 sel = `ALU_SRA;
       #10 $display("SRA: \t%d \t>> \t%d \t= \t%d", source_1, source_2, $signed(destination));
       #10 sel = `ALU_OR;
       #10 $display("OR: \t%d \t| \t%d \t= \t%d", source_1, source_2, destination);
       #10 sel = `ALU_AND;
       #10 $display("AND: \t%d \t& \t%d \t= \t%d", source_1, source_2, destination);
       #10 ;
       end
    endtask
	
	initial begin
        // Test both inputs positive
        $display("Both inputs positive");
        $display("Source_1 > Source_2");
        test_alu($signed(3), $signed(1));

        $display("\nSource_1 < Source_2");
        test_alu($signed(1), $signed(3));

        $display("\nSource_1 = Source_2");
        test_alu($signed(1), $signed(1));
        
        // A negative, B positive
        $display("\nA negative, B positive");
        $display("Source_1 > Source_2");
        test_alu($signed(-3), $signed(1));

        $display("\nSource_1 < Source_2");
        test_alu($signed(-1), $signed(3));

        $display("\nSource_1 = Source_2");
        test_alu($signed(-1), $signed(1));
        
        // Test both inputs positive
        $display("\nA Positive, B Negative");
        $display("Source_1 > Source_2");
        test_alu($signed(3), $signed(-1));

        $display("\nSource_1 < Source_2");
        test_alu($signed(1), $signed(-3));

        $display("\nSource_1 = Source_2");
        test_alu($signed(1), $signed(-1));
        
        // Test both inputs positive
        $display("\nBoth inputs negative");
        $display("Source_1 > Source_2");
        test_alu($signed(-3), $signed(-1));

        $display("\nSource_1 < Source_2");
        test_alu($signed(-1), $signed(-3));

        $display("\nSource_1 = Source_2");
        test_alu($signed(-1), $signed(-1));
       
		// Finish simulation
		#10 $finish;
	end
	
endmodule
