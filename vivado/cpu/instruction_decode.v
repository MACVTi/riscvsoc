module instruction_decode(
    input [31:0] instruction,
    output [6:0] opcode,
    output [3:0] rs1,
    output [3:0] rs2,
    output [3:0] rd
    );

	assign opcode = [6:0] instruction;
	assign rs1 = [18:15] instruction;
	assign rs2 = [23:20] instruction;
	assign rd = [10:7] instruction;

endmodule
