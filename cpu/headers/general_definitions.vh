// If the file hasn't been previously defined, define it now
`ifndef DEFINITIONS
	`define DEFINITIONS 1

	//------------------------------------------------------------
	// Opcodes
	//------------------------------------------------------------

	// Opcodes - Upper Immediates
	`define OP_LUI			7'b0110111	//LUI
	`define OP_AUIPC		7'b0010111	//AUIPC

	// Opcodes - Jumps
	`define OP_JAL			7'b1101111	//JAL
	`define OP_JALR			7'b1100111	//JALR

	// Opcodes - Branches
	`define OP_BEQ			7'b1100011	//BEQ
	`define OP_BNE			7'b1100011	//BNE
	`define OP_BLT			7'b1100011	//BLT
	`define OP_BGE			7'b1100011	//BGE
	`define OP_BLTU			7'b1100011	//BLTU
	`define OP_BGEU			7'b1100011	//BGEU

	// Opcodes - Loads
	`define OP_LB			7'b0000011	//LB
	`define OP_LH			7'b0000011	//LH
	`define OP_LW			7'b0000011	//LW
	`define OP_LBU			7'b0000011	//LBU
	`define OP_LHU			7'b0000011	//LHU

	// Opcodes - Stores
	`define OP_SB			7'b0100011	//SB
	`define OP_SH			7'b0100011	//SH
	`define OP_SW			7'b0100011	//SW

	// Opcodes - Register <-> Immediate
	`define OP_ADDI			7'b0010011	//ADDI
	`define OP_SLTI			7'b0010011	//SLTI
	`define OP_SLTIU		7'b0010011	//SLTIU
	`define OP_XORI			7'b0010011	//XORI
	`define OP_ORI			7'b0010011	//ORI
	`define OP_ANDI			7'b0010011	//ANDI
	`define OP_SLLI			7'b0010011	//SLLI
	`define OP_SRLI			7'b0010011	//SRLI
	`define OP_SRAI			7'b0010011	//SRAI

	// Opcodes - Register <-> Register
	`define OP_ADD			7'b0110011	//ADD
	`define OP_SUB			7'b0110011	//SUB
	`define OP_SLL			7'b0110011	//SLL
	`define OP_SLT			7'b0110011	//SLT
	`define OP_SLTU			7'b0110011	//SLTU
	`define OP_XOR			7'b0110011	//XOR
	`define OP_SRL			7'b0110011	//SRL
	`define OP_SRA			7'b0110011	//SRA
	`define OP_OR			7'b0110011	//OR
	`define OP_AND			7'b0110011	//AND

	// Note - Not sure if these opcodes are needed
	//`define OP_FENCE		7'b0001111	//FENCE
	//`define OP_FENCEI		7'b0001111	//FENCEI

	`define OP_ECALL		7'b1110011	//ECALL
	`define OP_EBREAK		7'b1110011	//EBREAK

	`define OP_CSRRW		7'b1110011	//CSRRW
	`define OP_MRET    		7'b1110011	//CSRRW

	//------------------------------------------------------------
	// Functions
	//------------------------------------------------------------

	// Functions - Jumps
	`define FUNC_JALR		3'b000		//JALR

	// Functions - Branches
	`define FUNC_BEQ		3'b000		//BEQ
	`define FUNC_BNE		3'b001		//BNE
	`define FUNC_BLT		3'b100		//BLT
	`define FUNC_BGE		3'b101		//BGE
	`define FUNC_BLTU		3'b110		//BLTU
	`define FUNC_BGEU		3'b111		//BGEU

	// Functions - Loads
	`define FUNC_LB			3'b000		//LB
	`define FUNC_LH			3'b001		//LH
	`define FUNC_LW			3'b010		//LW
	`define FUNC_LBU		3'b100		//LBU
	`define FUNC_LHU		3'b101		//LHU

	// Functions - Stores
	`define FUNC_SB			3'b000		//SB
	`define FUNC_SH			3'b001		//SH
	`define FUNC_SW			3'b010		//SW

	// Functions - Register <-> Immediates
	`define FUNC_ADDI		3'b000		//ADDI
	`define FUNC_SLTI		3'b010		//SLTI
	`define FUNC_SLTIU		3'b011		//SLTIU
	`define FUNC_XORI		3'b100		//XORI
	`define FUNC_ORI		3'b110		//ORI
	`define FUNC_ANDI		3'b111		//ANDI
	`define FUNC_SLLI		3'b001		//SLLI
	`define FUNC_SRLI		3'b101		//SRLI
	`define FUNC_SRAI		3'b101		//SRAI - Same as SRLI

	// Functions - Register <-> Register
	`define FUNC_ADD		3'b000		//ADD
	`define FUNC_SUB		3'b000		//SUB - Same as ADD
	`define FUNC_SLL		3'b001	    //SLL
    `define FUNC_SLT        3'b010      //SLT
    `define FUNC_SLTU       3'b011      //SLTU
    `define FUNC_XOR        3'b100      //XOR
    `define FUNC_SRL        3'b101      //SRL
    `define FUNC_SRA        3'b101      //SRA
    `define FUNC_OR         3'b110      //OR
    `define FUNC_AND        3'b111      //AND

    `define FUNC_ECALL      3'b000      //ECALL
    `define FUNC_EBREAK     3'b000      //EBREAK
    
    `define FUNC_CSRRW      3'b001      //CSRRW
    `define FUNC_MRET       3'b000      //MRET

	//------------------------------------------------------------
	// Register / ABI
	//------------------------------------------------------------

	// Register Definitions
	`define X0 		5'b00000		// Zero
	`define X1 		5'b00001		// Return Address
	`define X2 		5'b00010		// Stack Pointer
	`define X3 		5'b00011		// Global Pointer
	`define X4 		5'b00100		// Thread Pointer
	`define X5 		5'b00101		// Temporary Register 0
	`define X6 		5'b00110		// Temporary Register 1
	`define X7 		5'b00111		// Temporary Register 2
	`define X8 		5'b01000		// Callee-Saved Register 0 / Frame Pointer
	`define X9 		5'b01001		// Callee-Saved Register 1
	`define X10 	5'b01010		// Argument Register 0
	`define X11		5'b01011		// Argument Register 1
	`define X12		5'b01100		// Argument Register 2
	`define X13		5'b01101		// Argument Register 3
	`define X14		5'b01110		// Argument Register 4
	`define X15		5'b01111		// Argument Register 5

	// ABI Definitions
	`define ZERO 	5'b00000		// Zero
	`define RA 		5'b00001		// Return Address
	`define SP 		5'b00010		// Stack Pointer
	`define GP 		5'b00011		// Global Pointer
	`define TP 		5'b00100		// Thread Pointer
	`define T0 		5'b00101		// Temporary Register 0
	`define T1 		5'b00110		// Temporary Register 1
	`define T2 		5'b00111		// Temporary Register 2
	`define S0 		5'b01000		// Callee-Saved Register 0
	`define FP 		5'b01000		// Frame Pointer
	`define S1 		5'b01001		// Callee-Saved Register 1
	`define A0 		5'b01010		// Argument Register 0
	`define A1		5'b01011		// Argument Register 1
	`define A2		5'b01100		// Argument Register 2
	`define A3		5'b01101		// Argument Register 3
	`define A4		5'b01110		// Argument Register 4
	`define A5		5'b01111		// Argument Register 5
	
	// MSR Definitions
    `define MCAUSE          2'b00        // Machine Cause Register
    `define MSTATUS         2'b01        // Machine Status Register
    `define MEPC            2'b10        // Machine Exception Program Counter
    `define MEVECT          2'b11        // Machine Trap-Vector Base-Address
`endif
