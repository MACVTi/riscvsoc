// Written by Jack McEllin - 15170144
// A testbench for testing the privilege block of the CPU
module privilege_tb;
	
	//Declare Registers and Wires
	reg clk;
	reg reset;
	
	// Interrupt / Exception Sources
	reg ecall;
	reg ebreak;
	reg illegalinst;
	reg extinterrupt;
	
	// MEPC
	reg [31:0] pc;
	
	// MSR Read / Write
	reg msrwen;
    reg [11:0] csraddr;
    reg [3:0] rs1addr;
    reg [31:0] rs1data;
    wire [31:0] csrdata;
    
    // Mux_interrupt
    wire exception;
    wire [31:0] mux_epc_return;
    wire [31:0] mux_mevect;
    
	// Debug
	wire [2:0] mstatus;
	wire [4:0] mcause;
	wire [31:0] mepc;
	wire [31:0] mevect;

	//Instantiate Modules
	privilege #(
	   .VECTOR(32'h00000004)
	)
	privilege(
		.I_clk(clk),
		.I_rst(reset),
        
        // Software interrupts
        .I_ecall(ecall),
        .I_ebreak(ebreak),
        .I_illegalinst(illegalinst),
        
        // Hardware interrupts
        .I_extinterrupt(extinterrupt),
        
        
        // MSR Read/Write connections
        .I_pc(pc),
        .I_msrwen(msrwen),
        .I_csraddr(csraddr),
        .I_rs1addr(rs1addr),
        .I_rs1data(rs1data),
        .O_csrdata(csrdata),
        
        // Mux_interrupt select
        .O_exception(exception),
        .O_epcreturn(mux_epc_return),
        .O_evect(mux_mevect),
        
        // Debug connections
        .mstatus(mstatus),
        .mcause(mcause),
        .mepc(mepc),
        .mevect(mevect)
        );

	// Start running clock
	always begin
		#5 clk = ~clk;
	end

	initial begin
		// Initialise testbench
		clk = 1; reset = 0; csraddr = 12'h000; rs1addr= 4'b0001; rs1data = 32'hFFFFFFFF; msrwen = 1; 
        extinterrupt = 0; illegalinst = 0; ebreak = 0; ecall = 0; pc = 32'h00000000;
        
        // Let's test the posedge of the block (Read/Writing to the Machine Status Registers)
        $display("Checking read-only addresses don't write to MSR");
        $display("rs1data = %h", rs1data);
        
        // Check read-only addresses can't write to MSR
        #10 csraddr = 12'hFC0;
        #10 $display("csraddr = %h, mstatus = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC1;
        #10 $display("csraddr = %h, mcause = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC2;
        #10 $display("csraddr = %h, mepc = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC3;
        #10 $display("csraddr = %h, mevect = %b", csraddr, csrdata);

        // Check read-write addresses can't write to MSR when msrwen = 0
        $display("\nChecking read-write addresses don't write to MSR when msrwen = 0");
        $display("rs1data = %h", rs1data);
        
        #10 csraddr = 12'h7C0; msrwen = 0;
        #10 $display("csraddr = %h, mstatus = %b", csraddr, csrdata);
        #10 csraddr = 12'h7C1;
        #10 $display("csraddr = %h, mcause = %b", csraddr, csrdata);
        #10 csraddr = 12'h7C2;
        #10 $display("csraddr = %h, mepc = %b", csraddr, csrdata);
        #10 csraddr = 12'h7C3;
        #10 $display("csraddr = %h, mevect = %b", csraddr, csrdata);
        
        // Check invalid read address        
        $display("\nChecking invalid read address output's zero on csr_data");
        #10 csraddr = 12'h000;
        #10 $display("csraddr = %h, csrdata = %b", csraddr, csrdata);
        
        // Check write addresses can write to MSR
        $display("\nChecking read-write addresses write to MSR when msrwen = 1");
        $display("Note: The output value of csrdata will be the previous value in the msr");
        #10 csraddr = 12'h7C0; msrwen = 1;
        #10 $display("csraddr = %h, mstatus = %b", csraddr, csrdata);
        #10 csraddr = 12'h7C1;
        #10 $display("csraddr = %h, mcause = %b", csraddr, csrdata);
        #10 csraddr = 12'h7C2;
        #10 $display("csraddr = %h, mepc = %b", csraddr, csrdata);
        #10 csraddr = 12'h7C3;
        #10 $display("csraddr = %h, mevect = %b", csraddr, csrdata);
        
        // Check invalid write address
        $display("\nChecking invalid write address output's zero on csr_data");
        #10 csraddr = 12'h000;
        #10 $display("csraddr = %h, csrdata = %b", csraddr, csrdata);
        
        // Check read-only addresses again to make sure O_csrdata has updated correctly
        $display("\nChecking read-only addresses to make sure that the MSR have updated with the new value");
        #10 csraddr = 12'hFC0; msrwen = 0;
        #10 $display("csraddr = %h, mstatus = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC1;
        #10 $display("csraddr = %h, mcause = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC2;
        #10 $display("csraddr = %h, mepc = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC3;
        #10 $display("csraddr = %h, mevect = %b", csraddr, csrdata);
        
//        // Make waveforms easier to read
//        #10 csraddr = 12'h000;
        
        // Check reset works correctly
        $display("\nChecking that reset re-initialises the registers correctly.");
        #10 reset = 1; msrwen = 0;
        #10 reset = 0;
        #10 csraddr = 12'hFC0;
        #10 $display("csraddr = %h, mstatus = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC1;
        #10 $display("csraddr = %h, mcause = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC2;
        #10 $display("csraddr = %h, mepc = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC3;
        #10 $display("csraddr = %h, mevect = %b", csraddr, csrdata);
        
        // Now let's check negedge parts of the privilege block (Interrupt control)
        $display("\n\nRunning Negedge tests now");
        
        $display("\nChecking Expections work correct when MEIE is 0");
        // Check execptions act correctly when MEIE is disabled
        $display("\nChecking illegal instruction exception");
        #10 pc = 32'h00000004;
        #5 illegalinst = 1;
        #10 $display("Exception = %h; PC = %h, EPC_RETURN = %h", exception, pc, mux_epc_return);
        #10 illegalinst = 0;
        #5 csraddr = 12'hFC0;
        #10 $display("csraddr = %h, mstatus = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC1;
        #10 $display("csraddr = %h, mcause = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC2;
        #10 $display("csraddr = %h, mepc = %b", csraddr, csrdata);
        
        $display("\nChecking ebreak exception");
        #10 pc = 32'h00000008;
        #5 ebreak = 1;
        #10 $display("Exception = %h; PC = %h, EPC_RETURN = %h", exception, pc, mux_epc_return);
        #10 ebreak = 0;
        #5 csraddr = 12'hFC0;
        #10 $display("csraddr = %h, mstatus = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC1;
        #10 $display("csraddr = %h, mcause = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC2;
        #10 $display("csraddr = %h, mepc = %b", csraddr, csrdata);
        
        $display("\nChecking ecall exception");
        #10 pc = 32'h0000000c;
        #5 ecall = 1;
        #10 $display("Exception = %h; PC = %h, EPC_RETURN = %h", exception, pc, mux_epc_return);
        #10 ecall = 0;
        #5 csraddr = 12'hFC0;
        #10 $display("csraddr = %h, mstatus = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC1;
        #10 $display("csraddr = %h, mcause = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC2;
        #10 $display("csraddr = %h, mepc = %b", csraddr, csrdata);
        
        $display("\nChecking Expections work correct when MEIE is 1");
        // Check execptions act correctly when MEIE is disabled
        $display("\nChecking illegal instruction exception");
        #5 csraddr = 12'h7C0; msrwen = 1; rs1data = 32'h00000001;
        #10 pc = 32'h00000004;  msrwen = 0;
        #5 illegalinst = 1;
        #10 $display("Exception = %h; PC = %h, EPC_RETURN = %h", exception, pc, mux_epc_return);
        #10 illegalinst = 0;
        #5 csraddr = 12'hFC0;
        #10 $display("csraddr = %h, mstatus = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC1;
        #10 $display("csraddr = %h, mcause = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC2;
        #10 $display("csraddr = %h, mepc = %b", csraddr, csrdata);
        
        $display("\nChecking ebreak exception");
        #5 csraddr = 12'h7C0; msrwen = 1; rs1data = 32'h00000001;
        #10 pc = 32'h00000008;  msrwen = 0;
        #5 ebreak = 1;
        #10 $display("Exception = %h; PC = %h, EPC_RETURN = %h", exception, pc, mux_epc_return);
        #10 ebreak = 0;
        #5 csraddr = 12'hFC0;
        #10 $display("csraddr = %h, mstatus = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC1;
        #10 $display("csraddr = %h, mcause = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC2;
        #10 $display("csraddr = %h, mepc = %b", csraddr, csrdata);
        
        $display("\nChecking ecall exception");
        #5 csraddr = 12'h7C0; msrwen = 1; rs1data = 32'h00000001;
        #10 pc = 32'h0000000c;  msrwen = 0;
        #5 ecall = 1;
        #10 $display("Exception = %h; PC = %h, EPC_RETURN = %h", exception, pc, mux_epc_return);
        #10 ecall = 0;
        #5 csraddr = 12'hFC0;
        #10 $display("csraddr = %h, mstatus = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC1;
        #10 $display("csraddr = %h, mcause = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC2;
        #10 $display("csraddr = %h, mepc = %b", csraddr, csrdata);
        
        $display("\nChecking External Interrupts work correctly");
        // Reset the msrs
        #10 reset = 1;
        #10 reset = 0;
        
        // Disable external interrupts and check that muxsel is 0
        $display("\nChecking interrupts don't occur when MEIE is 0");
        #5 csraddr = 12'h7C0; msrwen = 1; rs1data = 32'h00000000;
        #10 pc = 32'h0000000f;  msrwen = 0;
        #5 extinterrupt = 1;
        #10 $display("Exception = %h; PC = %h, EPC_RETURN = %h", exception, pc, mux_epc_return);
        #10 extinterrupt = 0;
        #5 csraddr = 12'hFC0;
        #10 $display("csraddr = %h, mstatus = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC1;
        #10 $display("csraddr = %h, mcause = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC2;
        #10 $display("csraddr = %h, mepc = %b", csraddr, csrdata);
        
        // Enable external interrupts and check that muxsel is 1
        $display("\nChecking interrupts occur when MEIE is 1");
        #5 csraddr = 12'h7C0; msrwen = 1; rs1data = 32'h00000001;
        #10 pc = 32'h0000000f;  msrwen = 0;
        #5 extinterrupt = 1;
        #10 $display("Exception = %h; PC = %h, EPC_RETURN = %h", exception, pc, mux_epc_return);
        #10 extinterrupt = 0;
        #5 csraddr = 12'hFC0;
        #10 $display("csraddr = %h, mstatus = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC1;
        #10 $display("csraddr = %h, mcause = %b", csraddr, csrdata);
        #10 csraddr = 12'hFC2;
        #10 $display("csraddr = %h, mepc = %b", csraddr, csrdata);

		// Finish simulation
		#10 $finish;
	end
	
endmodule
