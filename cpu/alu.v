// Written by Jack McEllin - 15170144
// A simple 2 input ALU

`include "alu_definitions.vh"

module alu(
    input wire [3:0] I_alusel,
	input wire signed [31:0] I_data1,
	input wire signed [31:0] I_data2,
	output reg signed [31:0] O_data
);

    always @(*) begin
        case(I_alusel)
            `ALU_ADD:    O_data <= I_data1 + I_data2;
            `ALU_SUB:    O_data <= I_data1 - I_data2;
            `ALU_SLL:    O_data <= I_data1 << I_data2;
            `ALU_SLT:    O_data <= ($signed(I_data1) < $signed(I_data2)) ? 1 : 0;
            `ALU_SLTU:   O_data <= (I_data1 < I_data2) ? 1 : 0;
            `ALU_XOR:    O_data <= I_data1 ^ I_data2;
            `ALU_SRL:    O_data <= I_data1 >> I_data2;
            `ALU_SRA:    O_data <= I_data1 >>> I_data2;
            `ALU_OR:     O_data <= I_data1 | I_data2;
            `ALU_AND:    O_data <= I_data1 & I_data2;
            `ALU_LUI:    O_data <= I_data2;
            default:     O_data <= 20'hFFFFF; // Defaults to ADD
        endcase
    end

endmodule
