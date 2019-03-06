// Written by Jack McEllin - 15170144
// A module for generating immediate addresses

`include "load_generator.vh"

module load_generator(
    input wire [2:0] I_loadsel,
    input wire [31:0] I_data,
    output reg [31:0] O_data
    );
    
    always @(*) begin
        case(I_loadsel)
            `LOAD_LB: O_data = {{24{I_data[7]}},I_data[7:0]};
            `LOAD_LH: O_data = {{16{I_data[15]}},I_data[15:0]};
            `LOAD_LW: O_data = I_data;
            `LOAD_LBU: O_data = {24'h000000,I_data[7:0]};
            `LOAD_LHU: O_data = {16'h0000,I_data[15:0]};
            default: O_data = I_data;  //Default to LW
        endcase
    end
    
endmodule
