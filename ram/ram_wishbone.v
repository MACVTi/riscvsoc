// Written by Jack McEllin - 15170144
// A wishbone bus compatible ram module

module ram_wishbone #(parameter SIZE=1024) (
	input wire CLK_I,
	input wire RST_I,
	input wire STB_I,
	input wire WE_I,
	input wire [31:0] ADR_I,
	input wire [31:0] DAT_I,
	output wire [31:0] DAT_O
	);
	
	  // Declare some memory that we can use for data memory
    reg [7:0] memory [0:SIZE-1];
    integer i;

    initial begin
        // Initialise the memory with zeros before loading instruction
        $display("Initialising the data memory with zeros");
        for (i=0; i<SIZE; i=i+1) begin
            memory[i]= 8'h00;
        end
    end

	always @ (posedge CLK_I) begin
	    if(RST_I == 1'b1) begin
	        for (i=0; i<SIZE; i=i+1) begin
                memory[i]<= 8'h00;
            end
	    end
        else if(STB_I == 1'b1) begin
            if (WE_I == 1'b1) begin
                {memory[ADR_I+3],memory[ADR_I+2],memory[ADR_I+1],memory[ADR_I]} <= DAT_I;
                
            end
        end
    end  
    
    // Connect output to memory
    assign DAT_O = {memory[ADR_I+3],memory[ADR_I+2],memory[ADR_I+1],memory[ADR_I]};
    
endmodule
