// Written by Jack McEllin - 15170144
// A three-input multiplexor

module mux3(
		input wire [1:0] I_sel,
		input wire [31:0] I_data1,
		input wire [31:0] I_data2,
		input wire [31:0] I_data3,
		output reg [31:0] O_data
	  );

    always @(*) begin
        case(I_sel)
            2'b00: O_data = I_data1;
            2'b01: O_data = I_data2;
            2'b10: O_data = I_data3;
            default: O_data = 32'h00000000;
        endcase
    end

endmodule
