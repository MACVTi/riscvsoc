`ifndef _control_vh_
    `define _control_vh_

    //------------------------------------------------------------
    // Control Input Codes
    //------------------------------------------------------------

	// Opcodes - Upper Immediates
	`define CONTROL_IN_LUI			        12'b?????01101??	//LUI
	`define CONTROL_IN_AUIPC	    	    12'b?????00101??	//AUIPC
                                    
	// Opcodes - Jumps              
	`define CONTROL_IN_JAL			        12'b?????11011??	//JAL
	`define CONTROL_IN_JALR		            12'b??00011001??	//JALR
                                    
	// Opcodes - Branches - True           
	`define CONTROL_IN_BEQ_TRUE			    12'b??000110001?	//BEQ
	`define CONTROL_IN_BNE_TRUE			    12'b??001110000?	//BNE
	`define CONTROL_IN_BLT_TRUE			    12'b??10011000?1	//BLT
	`define CONTROL_IN_BGE_TRUE			    12'b??10111000?0	//BGE
	`define CONTROL_IN_BLTU_TRUE	        12'b??11011000?1	//BLTU
	`define CONTROL_IN_BGEU_TRUE	        12'b??11111000?0	//BGEU

	// Opcodes - Branches - True           
	`define CONTROL_IN_BEQ_FALSE		    12'b??000110000?	//BEQ
	`define CONTROL_IN_BNE_FALSE		    12'b??001110001?	//BNE
	`define CONTROL_IN_BLT_FALSE		    12'b??10011000?0	//BLT
	`define CONTROL_IN_BGE_FALSE		    12'b??10111000?1	//BGE
	`define CONTROL_IN_BLTU_FALSE	        12'b??11011000?0	//BLTU
	`define CONTROL_IN_BGEU_FALSE	        12'b??11111000?1	//BGEU
	                                    
	// Opcodes - Loads              
	`define CONTROL_IN_LB			        12'b??00000000??	//LB
	`define CONTROL_IN_LH			        12'b??00100000??	//LH
	`define CONTROL_IN_LW			        12'b??01000000??	//LW
	`define CONTROL_IN_LBU			        12'b??10000000??	//LBU
	`define CONTROL_IN_LHU			        12'b??10100000??	//LHU
                                    
	// Opcodes - Stores             
	`define CONTROL_IN_SB			        12'b??00001000??	//SB
	`define CONTROL_IN_SH			        12'b??00101000??	//SH
	`define CONTROL_IN_SW			        12'b??01001000??	//SW
                                    
	// Opcodes - Register <-> Immediate
	`define CONTROL_IN_ADDI		            12'b??00000100??	//ADDI
	`define CONTROL_IN_SLTI		            12'b??01000100??	//SLTI
	`define CONTROL_IN_SLTIU	            12'b??01100100??	//SLTIU
	`define CONTROL_IN_XORI		            12'b??10000100??	//XORI
	`define CONTROL_IN_ORI		            12'b??11000100??	//ORI
	`define CONTROL_IN_ANDI		            12'b??11100100??	//ANDI
	`define CONTROL_IN_SLLI		            12'b0?00100100??	//SLLI
	`define CONTROL_IN_SRLI		            12'b0?10100100??	//SRLI
	`define CONTROL_IN_SRAI		            12'b1?10100100??	//SRAI
                                    
	// Opcodes - Register <-> Register
	`define CONTROL_IN_ADD			        12'b0?00001100??	//ADD
	`define CONTROL_IN_SUB			        12'b1?00001100??	//SUB
	`define CONTROL_IN_SLL			        12'b0?00101100??	//SLL
	`define CONTROL_IN_SLT			        12'b0?01001100??	//SLT
	`define CONTROL_IN_SLTU			        12'b0?01101100??	//SLTU
	`define CONTROL_IN_XOR			        12'b0?10001100??	//XOR
	`define CONTROL_IN_SRL			        12'b0?10101100??	//SRL
	`define CONTROL_IN_SRA			        12'b1?10101100??	//SRA
	`define CONTROL_IN_OR			        12'b0?11001100??	//OR
	`define CONTROL_IN_AND			        12'b0?11101100??	//AND
	
	// Opcodes - Register <-> Register
	`define CONTROL_IN_ECALL			    12'b0000011100??	//ECALL
	`define CONTROL_IN_EBREAK			    12'b0100011100??	//EBREAK
	
    //------------------------------------------
    // Control Output Codes
    //
    // Note: Where the control doesn't matter, 
    //       we will set a zero                      
    //------------------------------------------
                                            
    // Opcodes - Upper Immediates              
    `define CONTROL_OUT_LUI         20'b00110011010010101001    //LUI
    `define CONTROL_OUT_AUIPC       20'b00110110000010101001    //AUIPC
                                            
    // Opcodes - Jumps                         
    `define CONTROL_OUT_JAL         20'b11000110000010101010    //JAL
    `define CONTROL_OUT_JALR        20'b10000010000010101010    //JALR
                                            
    // Opcodes - Branches - True                  
    `define CONTROL_OUT_BEQ_TRUE    20'b10100110000000101000    //BEQ
    `define CONTROL_OUT_BNE_TRUE    20'b10100110000000101000   //BNE
    `define CONTROL_OUT_BLT_TRUE    20'b10100110000000101000    //BLT
    `define CONTROL_OUT_BGE_TRUE    20'b10100110000000101000    //BGE
    `define CONTROL_OUT_BLTU_TRUE   20'b10101110000000101000    //BLT
    `define CONTROL_OUT_BGEU_TRUE   20'b10101110000000101000    //BGE

    // Opcodes - Branches - True                  
    `define CONTROL_OUT_BEQ_FALSE   20'b00100110000000101000    //BEQ
    `define CONTROL_OUT_BNE_FALSE   20'b00100110000000101000    //BNE
    `define CONTROL_OUT_BLT_FALSE   20'b00100110000000101000    //BLT
    `define CONTROL_OUT_BGE_FALSE   20'b00100110000000101000    //BGE
    `define CONTROL_OUT_BLTU_FALSE  20'b00101110000000101000    //BLT
    `define CONTROL_OUT_BGEU_FALSE  20'b00101110000000101000    //BGE
                                                
    // Opcodes - Loads                         
    `define CONTROL_OUT_LB          20'b00000010000010001000    //LB  
    `define CONTROL_OUT_LH          20'b00000010000010011000    //LH  
    `define CONTROL_OUT_LW          20'b00000010000010101000    //LW  
    `define CONTROL_OUT_LBU         20'b00000010000010111000    //LBU
    `define CONTROL_OUT_LHU         20'b00000010000011001000    //LHU
                                            
    // Opcodes - Stores                        
    `define CONTROL_OUT_SB          20'b00010010000100100000    //SB  
    `define CONTROL_OUT_SH          20'b00010010000100100100    //SH  
    `define CONTROL_OUT_SW          20'b00010010000100101000    //SW  
                                            
    // Opcodes - Register <-> Immediate        
    `define CONTROL_OUT_ADDI        20'b00000010000010101001    //ADDI
    `define CONTROL_OUT_SLTI        20'b00000010011010101001    //SLTI
    `define CONTROL_OUT_SLTIU       20'b00000010100010101001    //SLTIU
    `define CONTROL_OUT_XORI        20'b00000010101010101001    //XORI
    `define CONTROL_OUT_ORI         20'b00000011000010101001    //ORI
    `define CONTROL_OUT_ANDI        20'b00000011001010101001    //ANDI
    `define CONTROL_OUT_SLLI        20'b01010010010010101001    //SLLI
    `define CONTROL_OUT_SRLI        20'b01010010110010101001    //SRLI
    `define CONTROL_OUT_SRAI        20'b01010010111010101001    //SRAI
                                            
    // Opcodes - Register <-> Register         
    `define CONTROL_OUT_ADD         20'b00000000000010101001    //ADD
    `define CONTROL_OUT_SUB         20'b00000000001010101001    //SUB
    `define CONTROL_OUT_SLL         20'b00000000010010101001    //SLL
    `define CONTROL_OUT_SLT         20'b00000000011010101001    //SLT
    `define CONTROL_OUT_SLTU        20'b00000000100010101001    //SLTU
    `define CONTROL_OUT_XOR         20'b00000000101010101001    //XOR
    `define CONTROL_OUT_SRL         20'b00000000110010101001    //SRL
    `define CONTROL_OUT_SRA         20'b00000000111010101001    //SRA
    `define CONTROL_OUT_OR          20'b00000001000010101001    //OR  
    `define CONTROL_OUT_AND         20'b00000001001010101001    //AND	
`endif