`ifndef _control_vh_
`define _control_vh_

//------------------------------------------------------------
// Control Input Codes
//------------------------------------------------------------

	// Opcodes - Upper Immediates
	`define CONTROL_IN_LUI			9'bzzzz01101	//LUI
	`define CONTROL_IN_AUIPC		9'bzzzz00101	//AUIPC

	// Opcodes - Jumps
	`define CONTROL_IN_JAL			9'bzzzz11011	//JAL
	`define CONTROL_IN_JALR		    9'bz00011001	//JALR

	// Opcodes - Branches
	`define CONTROL_IN_BEQ			9'bz00011000	//BEQ
	`define CONTROL_IN_BNE			9'bz00111000	//BNE
	`define CONTROL_IN_BLT			9'bz10011000	//BLT
	`define CONTROL_IN_BGE			9'bz10111000	//BGE
	`define CONTROL_IN_BLTU		    9'bz11011000	//BLTU
	`define CONTROL_IN_BGEU		    9'bz11111000	//BGEU

	// Opcodes - Loads
	`define CONTROL_IN_LB			9'bz00000000	//LB
	`define CONTROL_IN_LH			9'bz00100000	//LH
	`define CONTROL_IN_LW			9'bz01000000	//LW
	`define CONTROL_IN_LBU			9'bz10000000	//LBU
	`define CONTROL_IN_LHU			9'bz10100000	//LHU

	// Opcodes - Stores
	`define CONTROL_IN_SB			9'bz00001000	//SB
	`define CONTROL_IN_SH			9'bz00101000	//SH
	`define CONTROL_IN_SW			9'bz01001000	//SW

	// Opcodes - Register <-> Immediate
	`define CONTROL_IN_ADDI		    9'bz00000100	//ADDI
	`define CONTROL_IN_SLTI		    9'bz00100100	//SLTI
	`define CONTROL_IN_SLTIU	    9'bz01100100	//SLTIU
	`define CONTROL_IN_XORI		    9'bz10000100	//XORI
	`define CONTROL_IN_ORI		    9'bz11000100	//ORI
	`define CONTROL_IN_ANDI		    9'bz11100100	//ANDI
	`define CONTROL_IN_SLLI		    9'b000100100	//SLLI
	`define CONTROL_IN_SRLI		    9'b010100100	//SRLI
	`define CONTROL_IN_SRAI		    9'b110100100	//SRAI

	// Opcodes - Register <-> Register
	`define CONTROL_IN_ADD			9'b000001100	//ADD
	`define CONTROL_IN_SUB			9'b100001100	//SUB
	`define CONTROL_IN_SLL			9'b000101100	//SLL
	`define CONTROL_IN_SLT			9'b001001100	//SLT
	`define CONTROL_IN_SLTU			9'b001101100	//SLTU
	`define CONTROL_IN_XOR			9'b010001100	//XOR
	`define CONTROL_IN_SRL			9'b010101100	//SRL
	`define CONTROL_IN_SRA			9'b110101100	//SRA
	`define CONTROL_IN_OR			9'b011001100	//OR
	`define CONTROL_IN_AND			9'b011101100	//AND
	
//------------------------------------------
// Control Output Codes
//
// Note: Where the control doesn't matter, 
//       we will set a zero                      
//------------------------------------------
                                            
    // Opcodes - Upper Immediates              
    `define CONTROL_OUT_LUI         14'bzzzzzzzzzzzzzz    //LUI
    `define CONTROL_OUT_AUIPC       14'bzzzzzzzzzzzzzz    //AU
                                            
    // Opcodes - Jumps                         
    `define CONTROL_OUT_JAL         14'bzzzzzzzzzzzzzz    //JAL
    `define CONTROL_OUT_JALR        14'bzzzzzzzzzzzzzz    //JAL
                                            
    // Opcodes - Branches                      
    `define CONTROL_OUT_BEQ         14'bzzzzzzzzzzzzzz    //BEQ
    `define CONTROL_OUT_BNE         14'bzzzzzzzzzzzzzz    //BNE
    `define CONTROL_OUT_BLT         14'bzzzzzzzzzzzzzz    //BLT
    `define CONTROL_OUT_BGE         14'bzzzzzzzzzzzzzz    //BGE
    `define CONTROL_OUT_BLTU        14'bzzzzzzzzzzzzzz    //BLT
    `define CONTROL_OUT_BGEU        14'bzzzzzzzzzzzzzz    //BGE
                                            
    // Opcodes - Loads                         
    `define CONTROL_OUT_LB          14'bzzzzzzzzzzzzzz    //LB  
    `define CONTROL_OUT_LH          14'bzzzzzzzzzzzzzz    //LH  
    `define CONTROL_OUT_LW          14'bzzzzzzzzzzzzzz    //LW  
    `define CONTROL_OUT_LBU         14'bzzzzzzzzzzzzzz    //LBU
    `define CONTROL_OUT_LHU         14'bzzzzzzzzzzzzzz    //LHU
                                            
    // Opcodes - Stores                        
    `define CONTROL_OUT_SB          14'bzzzzzzzzzzzzzz    //SB  
    `define CONTROL_OUT_SH          14'bzzzzzzzzzzzzzz    //SH  
    `define CONTROL_OUT_SW          14'bzzzzzzzzzzzzzz    //SW  
                                            
    // Opcodes - Register <-> Immediate        
    `define CONTROL_OUT_ADDI        14'bzzzzzzzzzzzzzz    //ADD
    `define CONTROL_OUT_SLTI        14'bzzzzzzzzzzzzzz    //SLT
    `define CONTROL_OUT_SLTIU       14'bzzzzzzzzzzzzzz    //SL
    `define CONTROL_OUT_XORI        14'bzzzzzzzzzzzzzz    //XOR
    `define CONTROL_OUT_ORI         14'bzzzzzzzzzzzzzz    //
    `define CONTROL_OUT_ANDI        14'bzzzzzzzzzzzzzz    //AND
    `define CONTROL_OUT_SLLI        14'bzzzzzzzzzzzzzz    //SLL
    `define CONTROL_OUT_SRLI        14'bzzzzzzzzzzzzzz    //SRL
    `define CONTROL_OUT_SRAI        14'bzzzzzzzzzzzzzz    //SRA
                                            
    // Opcodes - Register <-> Register         
    `define CONTROL_OUT_ADD         14'bzzzzzzzzzzzzzz    //ADD
    `define CONTROL_OUT_SUB         14'bzzzzzzzzzzzzzz    //SUB
    `define CONTROL_OUT_SLL         14'bzzzzzzzzzzzzzz    //SLL
    `define CONTROL_OUT_SLT         14'bzzzzzzzzzzzzzz    //SLT
    `define CONTROL_OUT_SLTU        14'bzzzzzzzzzzzzzz    //SL
    `define CONTROL_OUT_XOR         14'bzzzzzzzzzzzzzz    //XOR
    `define CONTROL_OUT_SRL         14'bzzzzzzzzzzzzzz    //SRL
    `define CONTROL_OUT_SRA         14'bzzzzzzzzzzzzzz    //SRA
    `define CONTROL_OUT_OR          14'bzzzzzzzzzzzzzz    //OR  
    `define CONTROL_OUT_AND         14'bzzzzzzzzzzzzzz    //AND	
`endif