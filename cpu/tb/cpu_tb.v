module cpu_tb;
	
	//Declare Registers and Wires
	reg clk;
	reg reset;
	
	//Control wires
	wire pcsel;
	wire [2:0] immsel;
	wire regwen;
	wire brun;
	wire breq;
	wire brlt;
	wire asel;
	wire bsel;
	wire [3:0] alusel;
	wire memrw;
    wire [2:0] loadsel;
    wire [1:0] storesel;
	wire [1:0] wbsel;

    //Data wires
    wire [31:0] pc_out;
    wire [31:0] pcincr_out;
    wire [31:0] decoder_out;
    wire [31:0] inst_out;
    wire [31:0] alu_out;
    wire [31:0] mux_pc_out;
    wire [31:0] mux_rs1_out;
    wire [31:0] mux_rs2_out;
    wire [31:0] register_out_a;
    wire [31:0] register_out_b;
    wire [31:0] immediate_out;
    wire [31:0] mem_out;
    wire [31:0] adder_out;
    wire [31:0] loadgen_out;
    wire [31:0] storegen_out;
    wire [31:0] mux_wb_out;
    
    wire [3:0] rs1_in;
    wire [3:0] rs2_in;
    wire [3:0] rd_in;
            
	//Instantiate Modules
    cpu #(
        .RESET(32'h00000000), 
        .INSTRUCTION_MEM("c_program_test.mem"),
        .DATA_MEM("")
    )
    cpu (
        .I_clk(clk),
        .I_rst(reset),
        
        // Control wires
        .PCSel(pcsel),
        .Immsel(immsel),
        .RegWEn(regwen),
        .BrUn(brun),
        .BrEq(breq),
        .BrLT(brlt),
        .ASel(asel),
        .BSel(bsel),
        .ALUSel(alusel),
        .MemRW(memrw),
        .LoadSel(loadsel),
        .StoreSel(storesel),
        .WBSel(wbsel),
        
        // Declare other wires
        .pc_out(pc_out),
        .pcincr_out(pcincr_out),
        .decoder_out(decoder_out),
        .inst_out(inst_out),
        .alu_out(alu_out),
        .mux_pc_out(mux_pc_out),
        .mux_rs1_out(mux_rs1_out),
        .mux_rs2_out(mux_rs2_out),
        .register_out_a(register_out_a),
        .register_out_b(register_out_b),
        .immediate_out(immediate_out),
        .mem_out(mem_out),
        .adder_out(adder_out),
        .loadgen_out(loadgen_out),
        .storegen_out(storegen_out),
        .mux_wb_out(mux_wb_out),
        
        .rs1_in(rs1_in),
        .rs2_in(rs2_in),
        .rd_in(rd_in)
        );

	// Start running clock
	always begin
		#5 clk = ~clk;
		if(clk == 1) begin
		  $display("\nNew Positive Clock Edge");
		end
	end

	initial begin
		// Initialise testbench
        clk = 0; reset = 1;
        
        #20 reset = 0;
        
		// Write test values to registers
		// Finish simulation
		#1000 $finish;
	end
	
endmodule
