`include "./definitions.vh"

module cpu #(parameter RESET=32'h00000000, INSTRUCTION_MEM="first_test.mem", DATA_MEM="data.mem") (
    input wire I_clk,
    input wire I_rst,
    
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
    output wire [1:0] WBSel,
    output wire [2:0] LoadSel,
    output wire [1:0] StoreSel,
    
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
    output wire [31:0] register_out_a,
    output wire [31:0] register_out_b,
    output wire [31:0] immediate_out,
    output wire [31:0] adder_out,
    output wire [31:0] loadgen_out,
    output wire [31:0] storegen_out,
    output wire [31:0] mux_wb_out,
    
    // Temporary wires
    output wire [3:0] rs1_in,
    output wire [3:0] rs2_in,
    output wire [3:0] rd_in 
    );
    
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
    // Control module
    //--------------------------------------//
    
    // Declare Control
    control ctrl(
        .I_control({decoder_out[30],decoder_out[14:12],decoder_out[6:2]}),
        .I_breq(BrEq),
        .I_brlt(BrLT),
        
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
        .O_wbsel(WBSel)
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
        .I_address(mux_pc_out), 
        .O_address(pc_out)
    );
    
    // Declare decoder
    decode decode(
        .I_clk(I_clk),
        .I_data(inst_out),
        .I_breq(BrEq),
        .I_brlt(BrLT),
        .O_pcincr(pcincr_out),
        .O_data(decoder_out)
    );
    
    // Declare registers - RV32E so only 16 registers
    assign rs1_in = decoder_out[18:15];
    assign rs2_in = decoder_out[23:20];
    assign rd_in = decoder_out[10:7];
    
    registers regs(
        .I_clk(I_clk),
        .I_rst(I_rst),
        .I_regwen(RegWEn),
        .I_rs1(rs1_in), //Note that these are four bits wide, not five bits
        .I_rs2(rs2_in), //Note that these are four bits wide, not five bits
        .I_rd(rd_in), //Note that these are four bits wide, not five bits
        .I_data(mux_wb_out),
        .O_data1(register_out_a),
        .O_data2(register_out_b)
    );
    
    // Declare branch comparator
    branch_comparator bc(
        .I_branch_unsigned(BrUn), 
        .I_data1(register_out_a), 
        .I_data2(register_out_b), 
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
        .I_data(register_out_b), 
        .O_data(storegen_out)
    );
     
    // Declare Adder
    add add(
        .I_data1(pc_out), 
        .I_data2(pcincr_out), 
        .O_data(adder_out)
    );

    // Declare 2 input muxes
    mux2 mux_pc(
        .I_sel(PCSel), 
        .I_data1(adder_out), 
        .I_data2(alu_out), 
        .O_data(mux_pc_out)
    );
    
    mux2 mux_rs1(
        .I_sel(ASel), 
        .I_data1(register_out_a), 
        .I_data2(pc_out), 
        .O_data(mux_rs1_out)
    );
    
    mux2 mux_rs2(
        .I_sel(BSel), 
        .I_data1(register_out_b), 
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

endmodule
