// Written by Jack McEllin - 15170144
// A two-input multiplexor

module mux3(
		input wire [1:0] I_sel,
		input wire [31:0] I_data1,
		input wire [31:0] I_data2,
		input wire [31:0] I_data3,
		output wire [31:0] O_data
	  );

    assign O_data = (I_sel == 2'b00) ? I_data1 : 
                      (I_sel == 2'b01) ? I_data2 :
                      (I_sel == 2'b10) ? I_data3 : 
                      32'h00000000;

endmodule
