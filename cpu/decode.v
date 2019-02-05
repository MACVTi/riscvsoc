module decode(
    input wire clk,
    input wire reset,
    input wire [31:0] encoded_instruction,
    output reg [2:0] pc_increment,
    output reg [31:0] decoded_instruction
    );

    // Initialise decoder on reset
    always @(posedge reset) begin
        pc_increment <= 4;
    end

    // Remember that input instruction is little endian.
    always @(posedge clk) begin
        if (encoded_instruction[25:24] == 2'b00) begin
            // RVC Quadrant 0 instruction
            decoded_instruction[7:0] <= encoded_instruction[31:24];
            
            // PC must be incremented by 2 next clock
            pc_increment <= 2;
        end
        else if (encoded_instruction[25:24] == 2'b01) begin
            // RVC Quadrant 1 instruction
            decoded_instruction[7:0] <= encoded_instruction[31:24];
            
            // PC must be incremented by 2 next clock
            pc_increment <= 2;
        end
        else if (encoded_instruction[25:24] == 2'b10) begin
            // RVC Quadrant 2 instruction
            decoded_instruction[7:0] <= encoded_instruction[31:24];
            
            // PC must be incremented by 2 next clock
            pc_increment <= 2;
        end
        else begin        
            // This is a 32 bit instruction, rearrange to big endian for simplicity
            decoded_instruction[31:24] <= encoded_instruction[7:0];
            decoded_instruction[23:16] <= encoded_instruction[15:8];
            decoded_instruction[15:8] <= encoded_instruction[23:16];
            decoded_instruction[7:0] <= encoded_instruction[31:24];
            
            // PC must be incremented by 4 next clock
            pc_increment <= 4;
        end
    end

endmodule
