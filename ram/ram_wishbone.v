// Written by Jack McEllin - 15170144
// A wishbone bus compatible ram module

module ram_wishbone (
	input wire CLK_I,
	input wire RST_I,
	input wire STB_I,
	input wire WE_I,
	input wire [31:0] ADR_I,
	input wire [31:0] DAT_I,
	output wire [31:0] DAT_O
	);
	
	  // Declare some memory that we can use for data memory
    reg [7:0] memory [0:63];
    integer i;
   
    // Connect output to memory
    assign DAT_O = {memory[ADR_I+3],memory[ADR_I+2],memory[ADR_I+1],memory[ADR_I]};
   
    initial begin
        // Initialise the memory with zeros before loading instruction
        $display("Initialising the data memory with zeros");
        for (i=0; i<63; i=i+1) begin
            memory[i]= 8'h00;
        end
    end

	always @ (posedge CLK_I) begin
	    if(RST_I) begin
	        for (i=0; i<63; i=i+1) begin
                memory[i]<= 8'h00;
            end
	    end
        else if(STB_I) begin
            if (WE_I == 1'b1) begin
                {memory[ADR_I+3],memory[ADR_I+2],memory[ADR_I+1],memory[ADR_I]} <= DAT_I;
                $display("STORE | DATA:%h\tADDRESS:%h", DAT_I, ADR_I);
            end
        end
    end  
endmodule
