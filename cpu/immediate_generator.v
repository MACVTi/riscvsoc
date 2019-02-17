// Written by Jack McEllin - 15170144
// A module for generating immediate addresses

`include "immgen.vh"

module immediate_generator(
    input wire [2:0] I_immsel,
    input wire [31:0] I_data,
    output reg [31:0] O_data
    );
    
    always @(*) begin
        casez(I_immsel)
            `IMM_ITYPE: O_data <= {{21{I_data[31]}},I_data[30:25],I_data[24:21],I_data[20]};
            `IMM_STYPE: O_data <= {{21{I_data[31]}},I_data[30:25],I_data[11:8],I_data[7]};
            `IMM_BTYPE: O_data <= {{20{I_data[31]}},I_data[7],I_data[30:25],I_data[11:8],1'b0};
            `IMM_UTYPE: O_data <= {I_data[31],I_data[30:20],I_data[19:12],12'b000000000000};
            `IMM_JTYPE: O_data <= {{12{I_data[31]}},I_data[19:12],I_data[20],I_data[30:25],I_data[24:21],1'b0};
            `IMM_RTYPE: O_data <= {27'b000000000000000000000000000,I_data[24:20]};
            default: O_data <= {{21{I_data[31]}},I_data[30:25],I_data[24:21],I_data[20]};  //Default to ITYPE
        endcase
    end
    
endmodule
