// Written by Jack McEllin - 15170144
// Definitions for the ALU module

`ifndef _alu_h_
    `define _alu_h_

    //------------------------------------------------------------
	// ALU function select values
	//------------------------------------------------------------

	`define ALU_ADD		   4'b0000		
	`define ALU_SUB		   4'b0001		
	`define ALU_SLL		   4'b0010
	`define ALU_SLT		   4'b0011
	`define ALU_SLTU       4'b0100
	`define ALU_XOR		   4'b0101
	`define ALU_SRL		   4'b0110
	`define ALU_SRA	       4'b0111
	`define ALU_OR		   4'b1000
	`define ALU_AND        4'b1001
	`define ALU_LUI        4'b1010

`endif