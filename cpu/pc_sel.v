// Written by Jack McEllin - 15170144
// A two-input multiplexor

module pc_sel(
        input wire I_clk,
        input wire I_interrupt,
		input wire [31:0] I_mtvec,
		input wire [31:0] I_pc,
		input wire [31:0] I_data,
		output reg [31:0] O_data
	  );

    reg [31:0] epc;

    // Store last interrupt state so we can check for posedge
    reg interrupt_previous;

    always @(negedge I_clk) begin
        // Check for I_interrupt positive edge 
        // This stops the PC being set to the machine trap vector address all the time
        if(I_interrupt == 1 && I_interrupt != interrupt_previous) begin
            epc <= I_pc;
            O_data <= I_mtvec;
        end
        else begin
            O_data <= I_data;
        end
        interrupt_previous <= I_interrupt;
    end

endmodule
