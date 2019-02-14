// Include opcodes for compressed instructions

module decode(
    input wire I_clk,
    input wire I_rst,
    input wire [31:0] I_data,
    output wire [31:0] O_pcincr,
    output wire [31:0] O_data
    );

    assign O_pcincr = 32'h00000004;
    assign O_data = I_data;

endmodule

    // Initialise decoder on reset
//    always @(posedge I_rst) begin
//        O_pcincr <= 4;
//    end


//    always @(posedge I_clk) begin
//        O_data <= I_data;
//    end    
    // Remember that input instruction is little endian, we will need to convert
    
//    always @(posedge I_clk) begin
//        if (I_data[25:24] == 2'b00) begin
//            // RVC Quadrant 0 instruction - Need to expand and convert to big endian
//            O_data[7:0] <= I_data[31:24];
       
//            if(I_data[23:21] == OP_C.LW) 
//            //C.LW
//            //C.SW
            
//            // PC must be incremented by 2 next clock
//            O_pcincr <= 2;
//        end
//        else if (I_data[25:24] == 2'b01) begin
//            // RVC Quadrant 1 instruction - Need to expand and convert to big endian
//            O_data[7:0] <= I_data[31:24];
            
//            //C.NOP
//            //C.ADDI[HINT]
//            //C.JAL
//            //C.LI[HINT]
//            //C.ANDI
//            //C.SUB
//            //C.XOR
//            //C.OR
//            //C.AND
//            //C.J
//            //C.BEQZ
//            //C.BNEZ
            
//            // PC must be incremented by 2 next clock
//            O_pcincr <= 2;
//        end
//        else if (I_data[25:24] == 2'b10) begin
//            // RVC Quadrant 2 instruction - Need to expand and convert to big endian
//            O_data[7:0] <= I_data[31:24];
            
//            //C.SLLI[HINT]
//            //C.MV[HINT]
//            //C.EBREAK
//            //C.JALR
//            //C.ADD[HINT]
//            //C.SWSP
//            //C.LSWP
            
//            // PC must be incremented by 2 next clock
//            O_pcincr <= 2;
//        end
//        else begin        
//            // This is a 32 bit instruction, rearrange to big endian for simplicity
//            O_data[31:24] <= I_data[7:0];
//            O_data[23:16] <= I_data[15:8];
//            O_data[15:8] <= I_data[23:16];
//            O_data[7:0] <= I_data[31:24];
            
//            // PC must be incremented by 4 next clock
//            O_pcincr <= 4;
//        end
//    end

//endmodule
