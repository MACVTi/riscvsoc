`include "./general_definitions.vh"

module cpu #(parameter RESET=32'h00000000, VECTOR=32'h00000000, INSTRUCTION_MEM="first_test.mem", DATA_MEM="data.mem") (
    input wire I_clk,
    input wire I_rst,
    input wire I_interrupt,
    
    // Control wires
    output wire PCSel,
    output wire [2:0] Immsel,
    output wire RegWEn,
    output wire BrUn,
    output wire BrEq,
    output wire BrLT,
    output wire ASel,
    output wire BSel,
    output wire [3:0] ALUSel,
    output wire MemRW,
    output wire [2:0] LoadSel,
    output wire [1:0] StoreSel,
    output wire [1:0] WBSel,
    output wire PrivSel,
    output wire MsrWEn,
    output wire CSRwbSel,
    
    // Privilege wires
    output wire flag_ecall,
    output wire flag_ebreak,
    output wire flag_illegalinst,
    output wire flag_exception,
    output wire [11:0] csr_addr_in,
    output wire [31:0] csr_data_out,
    output wire [31:0] mux_csr_out,
    output wire [31:0] mepc_ret_out,
    output wire [31:0] mevect_out,
    output wire [31:0] mux_privilege_out,

    // Declare other wires
    output wire [31:0] pc_out,
    output wire [31:0] pcincr_out,
    output wire [31:0] decoder_out,
    output wire [31:0] mem_out,
    output wire [31:0] inst_out,
    output wire [31:0] alu_out,
    output wire [31:0] mux_pc_out,
    output wire [31:0] mux_rs1_out,
    output wire [31:0] mux_rs2_out,
    output wire [31:0] rs1_data_out,
    output wire [31:0] rs2_data_out,
    output wire [31:0] immediate_out,
    output wire [31:0] adder_out,
    output wire [31:0] loadgen_out,
    output wire [31:0] storegen_out,
    output wire [31:0] mux_wb_out,

    // Register output wires
    output wire [3:0] rs1_addr_in,
    output wire [3:0] rs2_addr_in,
    output wire [3:0] rd_addr_in
    );
    
    wire [10:0] control_in;
    // Control wires
    assign control_in = {decoder_out[30],decoder_out[21:20],decoder_out[14:12],decoder_out[6:2]};
    
    // Declare privilege wires
    assign csr_addr_in = decoder_out[31:20];
        
    // Declare registers - RV32E so only 16 registers
    assign rs1_addr_in = decoder_out[18:15];
    assign rs2_addr_in = decoder_out[23:20];
    assign rd_addr_in = decoder_out[10:7];
    
    //--------------------------------------//
    // Memory modules
    //--------------------------------------//
    
    // Declare instruction memory
    instruction_memory #(
        .MEMFILE(INSTRUCTION_MEM)
    )
    inst (
        .I_clk(I_clk), 
        .I_address(pc_out), 
        .O_data(inst_out)
    );
    
    // Declare data memory
    data_memory #(
        .MEMFILE(DATA_MEM)
    )
    data (
        .I_clk(I_clk),
        .I_memrw(MemRW),
        .I_address(alu_out),
        .I_data(storegen_out),
        .O_data(mem_out)
    );
    
    //--------------------------------------//
    // Privilege module
    //--------------------------------------//
    
    privilege #(
         .VECTOR(VECTOR)
    ) 
    priv (
        .I_clk(I_clk),
        .I_rst(I_rst),
        
        .I_ecall(flag_ecall),
        .I_ebreak(flag_ebreak),
        .I_illegalinst(flag_illegalinst),
        .I_extinterrupt(I_interrupt),
        .I_mret(PrivSel),
        
        .I_pc(pc_out),
        .I_msrwen(MsrWEn),
        .I_csraddr(csr_addr_in),
        .I_rs1addr(rs1_addr_in),
        .I_rs1data(rs1_data_out),
        .O_csrdata(csr_data_out),
        
        .O_exception(flag_exception),
        .O_epcreturn(mepc_ret_out),
        .O_evect(mevect_out)
    );
    
    //--------------------------------------//
    // Control module
    //--------------------------------------//
    
    // Declare Control
    control ctrl(
        .I_control(control_in),
        .I_breq(BrEq),
        .I_brlt(BrLT),
        
        // Exception Flags
        .O_ecall(flag_ecall),
        .O_ebreak(flag_ebreak),
        .O_illegalinst(flag_illegalinst),
        
        // Standard Control Wires
        .O_pcsel(PCSel),
        .O_immsel(Immsel),
        .O_regwen(RegWEn),
        .O_brun(BrUn),
        .O_asel(ASel),
        .O_bsel(BSel),
        .O_alusel(ALUSel),
        .O_memrw(MemRW),
        .O_loadsel(LoadSel),
        .O_storesel(StoreSel),
        .O_wbsel(WBSel),
        
        // Privileged Control Wires
        .O_privsel(PrivSel),
        .O_msrwen(MsrWEn),
        .O_csrwbsel(CSRwbSel)
    );
    
    //--------------------------------------//
    // Main modules
    //--------------------------------------//
    
    // Declare Program Counter
    pc #(
        .RESET(32'h00000000)
    )
    pc (
        .I_clk(I_clk),
        .I_rst(I_rst),
        .I_address(mux_privilege_out), 
        .O_address(pc_out)
    );
    
    // Declare decoder
    decode decode(
//        .I_clk(I_clk),
        .I_data(inst_out),
        .O_pcincr(pcincr_out),
        .O_data(decoder_out),
        .O_illegalflag(flag_illegalinst)
    );
    
    registers regs(
        .I_clk(I_clk),
        .I_rst(I_rst),
        .I_regwen(RegWEn),
        .I_rs1(rs1_addr_in), //Note that these are four bits wide, not five bits
        .I_rs2(rs2_addr_in), //Note that these are four bits wide, not five bits
        .I_rd(rd_addr_in), //Note that these are four bits wide, not five bits
        .I_data(mux_csr_out),
        .O_data1(rs1_data_out),
        .O_data2(rs2_data_out)
    );
    
    // Declare branch comparator
    branch_comparator bc(
        .I_branch_unsigned(BrUn), 
        .I_data1(rs1_data_out), 
        .I_data2(rs2_data_out), 
        .O_branch_equal(BrEq), 
        .O_branch_lessthan(BrLT)
    );
        
    // Declare ALU
    alu alu(
        .I_alusel(ALUSel), 
        .I_data1(mux_rs1_out), 
        .I_data2(mux_rs2_out), 
        .O_data(alu_out)
    );
        
    // Declare Immediate Generator
    immediate_generator immediate(
        .I_immsel(Immsel), 
        .I_data(decoder_out), 
        .O_data(immediate_out)
    ); 
        
    //--------------------------------------//
    // Supporting modules
    //--------------------------------------//
    
    // Declare Adder
    load_generator loadgen(
        .I_loadsel(LoadSel), 
        .I_data(mem_out), 
        .O_data(loadgen_out)
    );
        
    // Declare Adder
    store_generator storegen(
        .I_storesel(StoreSel), 
        .I_data(rs2_data_out), 
        .O_data(storegen_out)
    );
     
    // Declare Adder
    add add(
        .I_data1(pc_out), 
        .I_data2(pcincr_out), 
        .O_data(adder_out)
    );

    mux2 mux_pc(
        .I_sel(PCSel), 
        .I_data1(adder_out), 
        .I_data2(alu_out), 
        .O_data(mux_pc_out)
    );
    
    mux2 mux_rs1(
        .I_sel(ASel), 
        .I_data1(rs1_data_out), 
        .I_data2(pc_out), 
        .O_data(mux_rs1_out)
    );
    
    mux2 mux_rs2(
        .I_sel(BSel), 
        .I_data1(rs2_data_out), 
        .I_data2(immediate_out),
        .O_data(mux_rs2_out)
    );
    
    // Declare 3 input mux
    mux3 mux3(
        .I_sel(WBSel), 
        .I_data1(loadgen_out), 
        .I_data2(alu_out), 
        .I_data3(adder_out), 
        .O_data(mux_wb_out)
    );
    
    // Declare mux privilege
    mux_privilege mux_priv(
            .I_exception(flag_exception),
            .I_privsel(PrivSel),
            .I_mevect(mevect_out),
            .I_data1(mux_pc_out),
            .I_data2(mepc_ret_out),
            .O_data(mux_privilege_out)
          );
    
    // Declare CSR writeback mux
    mux2 mux_csr(
            .I_sel(CSRwbSel), 
            .I_data1(mux_wb_out), 
            .I_data2(csr_data_out),
            .O_data(mux_csr_out)
    );
endmodule
