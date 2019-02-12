`include "./definitions.vh"

module cpu #(parameter VECTOR_RESET=32'h00000000, VECTOR_INTERRUPT = 32'h00000000) (
    input wire clk,
    input wire reset,
    output wire [31:0] pc_address,
    output wire [31:0] encoded_instruction,
    output wire [31:0] decoded_instruction
    );
    
    // Declare wires and regs
    wire [31:0] adder_to_pc;
    wire [31:0] pc_to_address;
    wire [2:0] decoder_to_adder;
    
    // Declare Program Counter
    pc pc(.clk(clk), .reset(reset), .data_in(adder_to_pc), .data_out(pc_address));

    // Declare instruction memory
    //instruction_memory #(
    //.MEMFILE("instruction.mem")
    //)
    //instruction(
    //        .clk(clk), 
    //        .address(pc_address), 
    //        .instruction(encoded_instruction)
    //);
    
    // Declare decoder
    
    // Declare adder 
    add add(.data_in1(pc_address), .data_in2(4), .data_out(adder_to_pc));
    
endmodule
