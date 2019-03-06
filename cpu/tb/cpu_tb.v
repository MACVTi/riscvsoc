module cpu_tb;
	
	//Declare Registers and Wires
	reg clk;
	reg reset;
	reg interrupt;
	
	wire O_data_memRW;
    wire [31:0] O_data_Addr_in;
    wire [31:0] O_data_Data_in;
    wire [31:0] I_data_Data_out;
//	//Control wires
//	wire pcsel;
//	wire [2:0] immsel;
//	wire regwen;
//	wire brun;
//	wire breq;
//	wire brlt;
//	wire asel;
//	wire bsel;
//	wire [3:0] alusel;
//	wire memrw;
//    wire [2:0] loadsel;
//    wire [1:0] storesel;
//	wire [1:0] wbsel;
//	wire privsel;
//	wire msrwen;
//	wire csrwbsel;

//    // Privilege wires
//    wire flag_ecall;
//    wire flag_ebreak;
//    wire flag_illegalinst;
//    wire flag_exception;
//    wire [11:0] csr_addr_in;
//    wire [31:0] csr_data_out;
//    wire [31:0] mux_csr_out;
//    wire [31:0] mepc_ret_out;
//    wire [31:0] mevect_out;
//    wire [31:0] mux_privilege_out;

//    //Data wires
//    wire [31:0] pc_out;
//    wire [31:0] pcincr_out;
//    wire [31:0] decoder_out;
//    wire [31:0] inst_out;
//    wire [31:0] alu_out;
//    wire [31:0] mux_pc_out;
//    wire [31:0] mux_rs1_out;
//    wire [31:0] mux_rs2_out;
//    wire [31:0] rs1_data_out;
//    wire [31:0] rs2_data_out;
//    wire [31:0] immediate_out;
//    wire [31:0] mem_out;
//    wire [31:0] adder_out;
//    wire [31:0] loadgen_out;
//    wire [31:0] storegen_out;
//    wire [31:0] mux_wb_out;
    
//    wire [3:0] rs1_addr_in;
//    wire [3:0] rs2_addr_in;
//    wire [3:0] rd_addr_in;
            
	//Instantiate Modules
    cpu #(
        .RESET(32'h00000000),
        .VECTOR(32'h00000010),
        .INSTRUCTION_MEM("led_test.mem"),
        .DATA_MEM("")
    )
    cpu (
        .I_clk(clk),
        .I_rst(reset),
        .I_interrupt(interrupt),
        
        // Data Memory Connections
        .O_data_memRW(O_data_memRW),
        .O_data_Addr_in(O_data_Addr_in),
        .O_data_Data_in(O_data_Data_in),
        .I_data_Data_out(I_data_Data_out)
        
//        // Control wires
//        .PCSel(pcsel),
//        .Immsel(immsel),
//        .RegWEn(regwen),
//        .BrUn(brun),
//        .BrEq(breq),
//        .BrLT(brlt),
//        .ASel(asel),
//        .BSel(bsel),
//        .ALUSel(alusel),
//        .MemRW(memrw),
//        .LoadSel(loadsel),
//        .StoreSel(storesel),
//        .WBSel(wbsel),
//        .PrivSel(privsel),
//        .MsrWEn(msrwen),
//        .CSRwbSel(csrwbsel),
        
//        // Privilege wires
//        .flag_ecall(flag_ecall),
//        .flag_ebreak(flag_ebreak),
//        .flag_illegalinst(flag_illegalinst),
//        .flag_exception(flag_exception),
//        .csr_addr_in(csr_addr_in),
//        .csr_data_out(csr_data_out),
//        .mux_csr_out(mux_csr_out),
//        .mepc_ret_out(mepc_ret_out),
//        .mevect_out(mevect_out),
//        .mux_privilege_out(mux_privilege_out),
        
//        // Declare other wires
//        .pc_out(pc_out),
//        .pcincr_out(pcincr_out),
//        .decoder_out(decoder_out),
//        .inst_out(inst_out),
//        .alu_out(alu_out),
//        .mux_pc_out(mux_pc_out),
//        .mux_rs1_out(mux_rs1_out),
//        .mux_rs2_out(mux_rs2_out),
//        .rs1_data_out(rs1_data_out),
//        .rs2_data_out(rs2_data_out),
//        .immediate_out(immediate_out),
//        .mem_out(mem_out),
//        .adder_out(adder_out),
//        .loadgen_out(loadgen_out),
//        .storegen_out(storegen_out),
//        .mux_wb_out(mux_wb_out),
        
//        .rs1_addr_in(rs1_addr_in),
//        .rs2_addr_in(rs2_addr_in),
//        .rd_addr_in(rd_addr_in)
        );

    data_memory data (
        .I_clk(clk),
        .I_memrw(O_data_memRW),
        .I_address(O_data_Addr_in),
        .I_data(O_data_Data_in),
        .O_data(I_data_Data_out)
    );

	// Start running clock
	always begin
		#5 clk = ~clk;
		if(clk == 1) begin
		  //$display("New Positive Clock Edge");
		end
	end

	initial begin
		// Initialise testbench
        clk = 1; interrupt = 0; reset = 1;
        
        #10 reset = 0;
        
//        #100 interrupt = 1;
//        #10 interrupt = 0;
 
//        #100 interrupt = 1;
//        $display("Testing External Interrupt");
//        #10 interrupt = 0;
		// Write test values to registers
		// Finish simulation
		#100 $finish;
	end
	
endmodule
