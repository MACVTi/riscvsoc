`include "./definitions.vh"

module cpu #(parameter RESET=32'h00000000, INSTRUCTION_MEM="instruction.mem", DATA_MEM="data.mem") (
    input wire I_clk,
    input wire I_rst,
    
    // Control wires
    output wire PCSel,
    output wire Immsel,
    output wire RegWEn,
    output wire BrUn,
    output wire BrEq,
    output wire BrLT,
    output wire ASel,
    output wire Bsel,
    output wire ALUSel,
    output wire MemRW,
    output wire WBSel,
    
    // Declare other wires
    output wire [31:0] mux_out,
    output wire [31:0] pc_out,
    output wire [31:0] pcincr_out,
    output wire [31:0] decoder_out,
    output wire [31:0] data_out,
    output wire [31:0] inst_out,
    output wire [31:0] alu_out,
    output wire [31:0] mux_pc_out,
    output wire [31:0] mux_rs1_out,
    output wire [31:0] register_out_a,
    output wire [31:0] register_out_b,
    output wire [31:0] immediate_out,
    output wire [31:0] mem_out,
    output wire [31:0] adder_out,
    output wire [31:0] mux_wb_out
    );
    
//    // Control wires
//    wire PCSel;
//    wire Immsel;
//    wire RegWEn;
//    wire BrUn;
//    wire BrEq;
//    wire BrLT;
//    wire ASel;
//    wire Bsel;
//    wire ALUSel;
//    wire MemRW;
//    wire WBSel;
    
//    // Declare other wires
//    wire [31:0] mux_out;
//    wire [31:0] pc_out;
//    wire [31:0] pcincr_out;
//    wire [31:0] decoder_out;
//    wire [31:0] data_out;
//    wire [31:0] inst_out;
//    wire [31:0] alu_out;
//    wire [31:0] mux_pc_out;
//    wire [31:0] mux_rs1_out;
//    wire [31:0] register_out_a;
//    wire [31:0] register_out_b;
//    wire [31:0] immediate_out;
//    wire [31:0] mem_out;
//    wire [31:0] adder_out;
//    wire [31:0] mux_wb_out;
    
    //--------------------------------------//
    // Memory modules
    //--------------------------------------//
    
    // Declare instruction memory
    instruction_memory #(
        .MEMFILE("")
    )
    inst (
        .I_clk(I_clk), 
        .I_address(pc_out), 
        .O_data(inst_out)
    );
    
    // Declare data memory
    data_memory #(
        .MEMFILE("")
    )
    data (
        .I_clk(I_clk),
        .I_memrw(MemRW),
        .I_address(alu_out),
        .I_data(register_out_b),
        .O_data(data_out)
    );
    
    //--------------------------------------//
    // Control module
    //--------------------------------------//
    
    // Declare Control
    control ctrl(
        .I_instruction(inst_out),
        .I_breq(BrEq),
        .I_brlt(BrLT),
        .O_alusel(ALUSel),
        .O_immsel(Immsel),
        .O_wbsel(WBSel),
        .O_pcsel(PCSel),
        .O_brun(BrUn),
        .O_asel(ASel),
        .O_bsel(BSel),
        .O_memrw(MemRW),
        .O_regwen(RegWEn)
    );
    
    //--------------------------------------//
    // Main modules
    //--------------------------------------//
    
    // Declare Program Counter
    pc #(
        .VECTOR_RESET(32'h00000000)
    )
    pc (
        .clk(I_clk),
        .reset(I_rst),
        .data_in(mux2_to_pc), 
        .data_out(pc_address)
    );
    
    // Declare decoder
    decode decode(
        .I_clk(I_clk),
        .I_rst(I_rst),
        .I_data(inst_out),
        .O_pcincr(pcincr_out),
        .O_data(decoder_out)
    );
    
    // Declare registers
    registers regs(
        .I_clk(I_clk),
        .I_rst(I_rst),
        .I_regwen(RegWEn),
        .I_rs1(inst_out[19:15]),
        .I_rs2(inst_out[24:20]),
        .I_rd(inst_out[11:7]),
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
        .I_data(inst_out), 
        .O_data(immediate_out)
    ); 
        
    
            
    //--------------------------------------//
    // Supporting modules
    //--------------------------------------//
     
    // Declare Adder
    add add(
        .data_in1(pc_out), 
        .data_in2(32'h00000004), 
        .data_out(adder_out)
    );

    // Declare 2 input muxes
    mux2 mux_pc(
        .I_sel(PCSel), 
        .I_data1(pc_out), 
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
        .I_data1(immediate_out), 
        .I_data2(register_out_b),
        .O_data(mux_rs2_out)
    );
    
    // Declare 3 input mux
    mux3 mux3(
        .I_sel(WBSel), 
        .I_data1(mem_out), 
        .I_data2(alu_out), 
        .I_data3(adder_out), 
        .O_data(mux_wb_out)
    );

endmodule
