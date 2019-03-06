// Written by Jack McEllin - 15170144
// A module for generating immediate addresses

`include "store_generator.vh"

module store_generator(
    input wire [1:0] I_storesel,
    input wire [31:0] I_data,
    output reg [31:0] O_data
    );
    
    always @(*) begin
        case(I_storesel)
            `STORE_SB: O_data = {24'h000000,I_data[7:0]};
            `STORE_SH: O_data = {16'h0000,I_data[15:0]};
            `STORE_SW: O_data = I_data;
            default: O_data = I_data;  //Default to SW
        endcase
    end
    
endmodule
