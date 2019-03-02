`ifndef _control_vh_
    `define _control_vh_

    //------------------------------------------------------------
    // Control Input Codes
    //------------------------------------------------------------

	// Opcodes - Upper Immediates
	`define CONTROL_IN_LUI			        13'b??????01101??	//LUI
	`define CONTROL_IN_AUIPC	    	    13'b??????00101??	//AUIPC
                                    
	// Opcodes - Jumps              
	`define CONTROL_IN_JAL			        13'b??????11011??	//JAL
	`define CONTROL_IN_JALR		            13'b???00011001??	//JALR
                                    
	// Opcodes - Branches - True           
	`define CONTROL_IN_BEQ_TRUE			    13'b???000110001?	//BEQ
	`define CONTROL_IN_BNE_TRUE			    13'b???001110000?	//BNE
	`define CONTROL_IN_BLT_TRUE			    13'b???10011000?1	//BLT
	`define CONTROL_IN_BGE_TRUE			    13'b???10111000?0	//BGE
	`define CONTROL_IN_BLTU_TRUE	        13'b???11011000?1	//BLTU
	`define CONTROL_IN_BGEU_TRUE	        13'b???11111000?0	//BGEU

	// Opcodes - Branches - True           
	`define CONTROL_IN_BEQ_FALSE		    13'b???000110000?	//BEQ
	`define CONTROL_IN_BNE_FALSE		    13'b???001110001?	//BNE
	`define CONTROL_IN_BLT_FALSE		    13'b???10011000?0	//BLT
	`define CONTROL_IN_BGE_FALSE		    13'b???10111000?1	//BGE
	`define CONTROL_IN_BLTU_FALSE	        13'b???11011000?0	//BLTU
	`define CONTROL_IN_BGEU_FALSE	        13'b???11111000?1	//BGEU
	                                    
	// Opcodes - Loads              
	`define CONTROL_IN_LB			        13'b???00000000??	//LB
	`define CONTROL_IN_LH			        13'b???00100000??	//LH
	`define CONTROL_IN_LW			        13'b???01000000??	//LW
	`define CONTROL_IN_LBU			        13'b???10000000??	//LBU
	`define CONTROL_IN_LHU			        13'b???10100000??	//LHU
                                    
	// Opcodes - Stores             
	`define CONTROL_IN_SB			        13'b???00001000??	//SB
	`define CONTROL_IN_SH			        13'b???00101000??	//SH
	`define CONTROL_IN_SW			        13'b???01001000??	//SW
                                    
	// Opcodes - Register <-> Immediate
	`define CONTROL_IN_ADDI		            13'b???00000100??	//ADDI
	`define CONTROL_IN_SLTI		            13'b???01000100??	//SLTI
	`define CONTROL_IN_SLTIU	            13'b???01100100??	//SLTIU
	`define CONTROL_IN_XORI		            13'b???10000100??	//XORI
	`define CONTROL_IN_ORI		            13'b???11000100??	//ORI
	`define CONTROL_IN_ANDI		            13'b???11100100??	//ANDI
	`define CONTROL_IN_SLLI		            13'b0??00100100??	//SLLI
	`define CONTROL_IN_SRLI		            13'b0??10100100??	//SRLI
	`define CONTROL_IN_SRAI		            13'b1??10100100??	//SRAI
                                    
	// Opcodes - Register <-> Register
	`define CONTROL_IN_ADD			        13'b0??00001100??	//ADD
	`define CONTROL_IN_SUB			        13'b1??00001100??	//SUB
	`define CONTROL_IN_SLL			        13'b0??00101100??	//SLL
	`define CONTROL_IN_SLT			        13'b0??01001100??	//SLT
	`define CONTROL_IN_SLTU			        13'b0??01101100??	//SLTU
	`define CONTROL_IN_XOR			        13'b0??10001100??	//XOR
	`define CONTROL_IN_SRL			        13'b0??10101100??	//SRL
	`define CONTROL_IN_SRA			        13'b1??10101100??	//SRA
	`define CONTROL_IN_OR			        13'b0??11001100??	//OR
	`define CONTROL_IN_AND			        13'b0??11101100??	//AND
	
	// Opcodes - Register <-> Register
	`define CONTROL_IN_ECALL			    13'b00000011100??	//ECALL
	`define CONTROL_IN_EBREAK			    13'b00100011100??	//EBREAK
	
	// Opcodes - Privilege
	`define CONTROL_IN_CSRRW  			    13'b???00111100??	//CSRRW
	`define CONTROL_IN_MRET    			    13'b01000011100??	//MRET
	
    //------------------------------------------
    // Control Output Codes
    //
    // Note: Where the control doesn't matter, 
    //       we will set a zero                      
    //------------------------------------------
                                            
    // Opcodes - Upper Immediates              
    `define CONTROL_OUT_LUI         23'b00110011010010101001000    //LUI
    `define CONTROL_OUT_AUIPC       23'b00110110000010101001000    //AUIPC
                                            
    // Opcodes - Jumps                         
    `define CONTROL_OUT_JAL         23'b11000110000010101010000    //JAL
    `define CONTROL_OUT_JALR        23'b10000010000010101010000    //JALR
                                            
    // Opcodes - Branches - True                  
    `define CONTROL_OUT_BEQ_TRUE    23'b10100110000000101000000    //BEQ
    `define CONTROL_OUT_BNE_TRUE    23'b10100110000000101000000   //BNE
    `define CONTROL_OUT_BLT_TRUE    23'b10100110000000101000000    //BLT
    `define CONTROL_OUT_BGE_TRUE    23'b10100110000000101000000    //BGE
    `define CONTROL_OUT_BLTU_TRUE   23'b10101110000000101000000    //BLT
    `define CONTROL_OUT_BGEU_TRUE   23'b10101110000000101000000    //BGE

    // Opcodes - Branches - True                  
    `define CONTROL_OUT_BEQ_FALSE   23'b00100110000000101000000    //BEQ
    `define CONTROL_OUT_BNE_FALSE   23'b00100110000000101000000    //BNE
    `define CONTROL_OUT_BLT_FALSE   23'b00100110000000101000000    //BLT
    `define CONTROL_OUT_BGE_FALSE   23'b00100110000000101000000    //BGE
    `define CONTROL_OUT_BLTU_FALSE  23'b00101110000000101000000    //BLT
    `define CONTROL_OUT_BGEU_FALSE  23'b00101110000000101000000    //BGE
                                                
    // Opcodes - Loads                         
    `define CONTROL_OUT_LB          23'b00000010000010001000000    //LB  
    `define CONTROL_OUT_LH          23'b00000010000010011000000    //LH  
    `define CONTROL_OUT_LW          23'b00000010000010101000000    //LW  
    `define CONTROL_OUT_LBU         23'b00000010000010111000000    //LBU
    `define CONTROL_OUT_LHU         23'b00000010000011001000000    //LHU
                                            
    // Opcodes - Stores                        
    `define CONTROL_OUT_SB          23'b00010010000100100000000    //SB  
    `define CONTROL_OUT_SH          23'b00010010000100100100000    //SH  
    `define CONTROL_OUT_SW          23'b00010010000100101000000    //SW  
                                            
    // Opcodes - Register <-> Immediate        
    `define CONTROL_OUT_ADDI        23'b00000010000010101001000    //ADDI
    `define CONTROL_OUT_SLTI        23'b00000010011010101001000    //SLTI
    `define CONTROL_OUT_SLTIU       23'b00000010100010101001000    //SLTIU
    `define CONTROL_OUT_XORI        23'b00000010101010101001000    //XORI
    `define CONTROL_OUT_ORI         23'b00000011000010101001000    //ORI
    `define CONTROL_OUT_ANDI        23'b00000011001010101001000    //ANDI
    `define CONTROL_OUT_SLLI        23'b01010010010010101001000    //SLLI
    `define CONTROL_OUT_SRLI        23'b01010010110010101001000    //SRLI
    `define CONTROL_OUT_SRAI        23'b01010010111010101001000    //SRAI
                                            
    // Opcodes - Register <-> Register         
    `define CONTROL_OUT_ADD         23'b00000000000010101001000    //ADD
    `define CONTROL_OUT_SUB         23'b00000000001010101001000    //SUB
    `define CONTROL_OUT_SLL         23'b00000000010010101001000    //SLL
    `define CONTROL_OUT_SLT         23'b00000000011010101001000    //SLT
    `define CONTROL_OUT_SLTU        23'b00000000100010101001000    //SLTU
    `define CONTROL_OUT_XOR         23'b00000000101010101001000    //XOR
    `define CONTROL_OUT_SRL         23'b00000000110010101001000    //SRL
    `define CONTROL_OUT_SRA         23'b00000000111010101001000    //SRA
    `define CONTROL_OUT_OR          23'b00000001000010101001000    //OR  
    `define CONTROL_OUT_AND         23'b00000001001010101001000    //AND	
                                                                  
    // Opcodes - Interrupts                                   
    `define CONTROL_OUT_CSRRW       23'b00000000000010001010011    //CSRRW
    `define CONTROL_OUT_MRET        23'b00000000000000001010100    //MRET
`endif