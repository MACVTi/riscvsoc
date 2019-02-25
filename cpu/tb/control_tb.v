`include "control_defintions.vh"

module control_tb;
	
	//Declare Registers and Wires
    reg [9:0] control;
    reg breq;
    reg brlt;
    
    wire pcsel;
    wire [2:0] immsel;
    wire regwen;
    wire brun;
    wire asel;
    wire bsel;
    wire [3:0] alusel;
    wire memrw;
    wire [2:0] loadsel;
    wire [1:0] storesel;
    wire [1:0] wbsel;

    
	//Instantiate Modules
    control ctrl(
        .I_control(control),
        .I_breq(breq),
        .I_brlt(brlt),
        
        .O_pcsel(pcsel),
        .O_immsel(immsel),
        .O_regwen(regwen),
        .O_brun(brun),
        .O_asel(asel),
        .O_bsel(bsel),
        .O_alusel(alusel),
        .O_memrw(memrw),
         .O_loadsel(loadsel),
        .O_storesel(storesel),
        .O_wbsel(wbsel)
    );

	initial begin
		// Initialise testbench

        // Opcodes - Upper Immediates
        $display("Control Codes for Upper Immediates");
        {control,breq,brlt} = `CONTROL_IN_LUI;
        #10 $display("LUI:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_AUIPC;
        #10 $display("AUIPC:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});

        
        // Opcodes - Jumps
        $display("\nControl Codes for Jumps");
        #10 {control,breq,brlt} = `CONTROL_IN_JAL;
        #10 $display("JAL:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_JALR; 
        #10 $display("JALR:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        
        // Opcodes - Branches  
        $display("\nControl Codes for Branches - True");
        #10 {control,breq,brlt} = `CONTROL_IN_BEQ_TRUE;  
        #10 $display("BEQ:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_BNE_TRUE; 
        #10 $display("BNE:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_BLT_TRUE;  
        #10 $display("BLT:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_BGE_TRUE;  
        #10 $display("BGE:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_BLTU_TRUE; 
        #10 $display("BLTU:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_BGEU_TRUE; 
        #10 $display("BGEU:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});

        // Opcodes - Branches  
        $display("\nControl Codes for Branches - False");
        #10 {control,breq,brlt} = `CONTROL_IN_BEQ_FALSE;  
        #10 $display("BEQ:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_BNE_FALSE; 
        #10 $display("BNE:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_BLT_FALSE;  
        #10 $display("BLT:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_BGE_FALSE;  
        #10 $display("BGE:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_BLTU_FALSE; 
        #10 $display("BLTU:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_BGEU_FALSE; 
        #10 $display("BGEU:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        
        // Opcodes - Loads 
        $display("\nControl Codes for Loads");
        #10 {control,breq,brlt} = `CONTROL_IN_LB; 
        #10 $display("LB:\t\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_LH; 
        #10 $display("LH:\t\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_LW; 
        #10 $display("LW:\t\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_LBU; 
        #10 $display("LBU:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_LHU;
        #10 $display("LHU:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        
        // Opcodes - Stores   
        $display("\nControl Codes for Stores");
        #10 {control,breq,brlt} = `CONTROL_IN_SB; 
        #10 $display("SB:\t\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_SH;   
        #10 $display("SH:\t\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_SW;  
        #10 $display("SW:\t\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        
        // Opcodes - Register <-> Immediate 
        $display("\nControl Codes for Register <-> Immediate Operations");
        #10 {control,breq,brlt} = `CONTROL_IN_ADDI;
        #10 $display("ADDI:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_SLTI; 
        #10 $display("SLTI:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_SLTIU;
        #10 $display("SLTIU:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_XORI; 
        #10 $display("XORI:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_ORI; 
        #10 $display("ORI:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_ANDI; 
        #10 $display("ANDI:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_SLLI; 
        #10 $display("SLLI:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_SRLI; 
        #10 $display("SRLI:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_SRAI; 
        #10 $display("SRAI:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        
        // Opcodes - Register <-> Register
        $display("\nControl Codes for Register <-> Register Operations");
        #10 {control,breq,brlt} = `CONTROL_IN_ADD; 
        #10 $display("ADD:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_SUB;
        #10 $display("SUB:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel}); 
        #10 {control,breq,brlt} = `CONTROL_IN_SLL;  
        #10 $display("SLL:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_SLT; 
        #10 $display("SLT:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_SLTU; 
        #10 $display("SLTU:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_XOR; 
        #10 $display("XOR:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_SRL;  
        #10 $display("SRL:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_SRA; 
        #10 $display("SRA:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_OR;  
        #10 $display("OR:\t\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        #10 {control,breq,brlt} = `CONTROL_IN_AND;  
        #10 $display("AND:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        
        // Test default case
        $display("\nTesting Default Case");
        #10 {control,breq,brlt} = 11'b11111111111;  
        #10 $display("DEFAULT:\tIn=%b, Out=%b", {control,breq,brlt}, {pcsel, immsel, regwen, brun, asel, bsel, alusel, memrw, loadsel, storesel, wbsel});
        
		// Write test values to registers
		// Finish simulation
		#10 $finish;
	end
	
endmodule
