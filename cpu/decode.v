`include "definitions.vh"

module decode(
    //input wire I_clk,
    input wire [31:0] I_data,
    output reg [31:0] O_pcincr,
    output reg [31:0] O_data
    );

//    assign O_pcincr = 32'h00000004;
//    assign O_data = I_data;
    
    always @(*) begin
        // Check for illegal instruction
        if(I_data == 32'h00000000) begin
            $stop();
        end
        
        // Check if 16 or 32 bit instruction
        if(I_data[1:0] == 2'b11) begin
            $display("This is a 32 bit instruction");
            
            // Display which instruction it is
            case(I_data[6:0])
                `OP_LUI:    $display("The current instruction is LUI");
                `OP_AUIPC:  $display("The current instruction is AUIPC");
                
                `OP_JAL:    $display("The current instruction is JAL");
                `OP_JALR:   $display("The current instruction is JALR");
        
                `OP_BEQ:    $display("The current instruction is BEQ");
                `OP_BNE:    $display("The current instruction is BNE");
                `OP_BLT:    $display("The current instruction is BLT");
                `OP_BGE:    $display("The current instruction is BGE");
                `OP_BLTU:   $display("The current instruction is BLTU");
                `OP_BGEU:   $display("The current instruction is BGEU");
        
                `OP_LB:     $display("The current instruction is LB");
                `OP_LH:     $display("The current instruction is LH");
                `OP_LW:     $display("The current instruction is LW");
                `OP_LBU:    $display("The current instruction is LBU");
                `OP_LHU:    $display("The current instruction is LHU");
        
                `OP_SB:     $display("The current instruction is SB");
                `OP_SH:     $display("The current instruction is SH");
                `OP_SW:     $display("The current instruction is SW");
        
                `OP_ADDI:   $display("The current instruction is ADDI");
                `OP_SLTI:   $display("The current instruction is SLTI");
                `OP_SLTIU:  $display("The current instruction is SLTIU");
                `OP_XORI:   $display("The current instruction is XORI");
                `OP_ORI:    $display("The current instruction is ORI");
                `OP_ANDI:   $display("The current instruction is ANDI");
                `OP_SLLI:   $display("The current instruction is SLLI");
                `OP_SRLI:   $display("The current instruction is SRLI");
                `OP_SRAI:   $display("The current instruction is SRAI");
        
                `OP_ADD:    $display("The current instruction is ADD");
                `OP_SUB:    $display("The current instruction is SUB");
                `OP_SLL:    $display("The current instruction is SLL");
                `OP_SLT:    $display("The current instruction is SLT");
                `OP_SLTU:   $display("The current instruction is SLT");
                `OP_XOR:    $display("The current instruction is XOR");
                `OP_SRL:    $display("The current instruction is SRL");
                `OP_SRA:    $display("The current instruction is SRA");
                `OP_OR:     $display("The current instruction is OR");
                `OP_AND:    $display("The current instruction is AND");
        
                `OP_ECALL:  $display("The current instruction is ECALL");
                `OP_EBREAK: $display("The current instruction is EBREAK");
            endcase

            // Pass through 32 bit instruction
            O_pcincr <= 32'h00000004;
            O_data <= I_data;
        end
        else begin
            // Increment by 2 for next instruction
            O_pcincr <= 32'h00000002;
            
            // Check which quadrant the 16 bit instruction is in
            if(I_data[1:0] == 2'b00) begin
                //  Quadrant 0
                $display("Quadrant 0 - 16 bit instruction");
                
                if(I_data[15:13] == 3'b000) begin
                    // C.ADDI4SPN
                    $display("The current instruction is C.ADDI4SPN");
                    O_data <= {{{2{I_data[10]}},I_data[10:7],I_data[12:11],I_data[5],I_data[6],2'b00},`X2,`FUNC_ADDI,{2'b00,I_data[4:2]},`OP_ADDI};
                end
                else if(I_data[15:13] == 3'b010) begin
                    // C.LW
                    $display("The current instruction is C.LW");
                    O_data <= {{5'b00000,I_data[5],I_data[12:10],I_data[6],2'b00},{2'b00,I_data[9:7]},`FUNC_LW,{2'b00,I_data[4:2]},`OP_LW};
                end
                else if(I_data[15:13] == 3'b110) begin
                    // C.SW
                    $display("The current instruction is C.SW");
                    O_data <= {{5'b00000,I_data[5],I_data[12]},{2'b00,I_data[4:2]},{2'b00,I_data[9:7]},`FUNC_SW,{I_data[11:10],I_data[6],2'b00},`OP_SW};
                end                
                else begin
                    $stop(); 
                end
            end
            else if(I_data[1:0] == 2'b01) begin
                // Quadrant 1
                $display("Quadrant 1 - 16 bit instruction");
                
                if(I_data[15:13] == 3'b000) begin
                    // C.NOP / C.ADDI
                    $display("The current instruction is C.ADDI");
                    O_data <= {{{6{I_data[12]}},I_data[12],I_data[6:2]},I_data[11:7],`FUNC_ADDI,I_data[11:7],`OP_ADDI};
                end
                else if(I_data[15:13] == 3'b001) begin
                    // C.JAL
                    $display("The current instruction is C.JAL");
                    O_data <= {I_data[12],{I_data[8],I_data[10:9],I_data[6],I_data[7],I_data[2],I_data[11],I_data[5:3]},I_data[12],{8{I_data[12]}},`X1,`OP_JAL};
                end
                else if(I_data[15:13] == 3'b010) begin
                    // C.LI
                    $display("The current instruction is C.LI");
                    O_data <= {{{6{I_data[12]}},I_data[12],I_data[6:2]},`X0,`FUNC_ADDI,I_data[11:7],`OP_ADDI};
                end
                else if(I_data[15:13] == 3'b011) begin
                    if(I_data[11:7] == `X2) begin
                        // C.ADDI16SP
                        $display("The current instruction is C.ADDI16SP");
                        O_data <= {{{2{I_data[12]}},I_data[12],I_data[4:3],I_data[5],I_data[2],I_data[6],4'b0000},`X2,`FUNC_ADDI,`X2,`OP_ADDI};
                    end
                    else begin
                        // C.LUI
                        $display("The current instruction is C.LUI");
                        O_data <= {{{2{I_data[12]}},I_data[12],I_data[6:2],12'b000000000000},I_data[11:7],`OP_LUI};
                    end
                end
                else if(I_data[15:13] == 3'b100) begin
                    if(I_data[11:10] == 2'b00) begin
                        // C.SRLI
                        $display("The current instruction is C.SRLI");
                        O_data <= {7'b0000000,I_data[6:2],{2'b00,I_data[9:7]},`FUNC_SRLI,{2'b00,I_data[9:7]},`OP_SRLI};
                    end
                    else if(I_data[11:10] == 2'b01) begin
                        // C.SRAI
                        $display("The current instruction is C.SRAI");
                        O_data <= {7'b0100000,I_data[6:2],{2'b00,I_data[9:7]},`FUNC_SRAI,{2'b00,I_data[9:7]},`OP_SRAI};
                    end
                    else if(I_data[11:10] == 2'b10) begin
                        // C.ANDI
                        $display("The current instruction is C.ANDI");
                        O_data <= {{{6{I_data[12]}},I_data[12],I_data[6:2]},{2'b00,I_data[9:7]},`FUNC_ANDI,{2'b00,I_data[9:7]},`OP_ANDI};
                    end
                    else begin
                        if(I_data[6:5] == 2'b00) begin
                            // C.SUB
                            $display("The current instruction is C.SUB");
                            O_data <= {7'b0100000,{2'b00,I_data[9:7]},`FUNC_SUB,{2'b00,I_data[9:7]},`OP_SUB};
                        end 
                        else if(I_data[6:5] == 2'b00) begin
                            // C.XOR
                            $display("The current instruction is C.XOR");
                            O_data <= {7'b0000000,{2'b00,I_data[9:7]},`FUNC_XOR,{2'b00,I_data[9:7]},`OP_XOR};
                        end  
                        else if(I_data[6:5] == 2'b00) begin
                            // C.OR
                            $display("The current instruction is C.OR");
                            O_data <= {7'b0000000,{2'b00,I_data[9:7]},`FUNC_OR,{2'b00,I_data[9:7]},`OP_OR};
                        end 
                        else begin
                            // C.AND
                            $display("The current instruction is C.AND");
                            O_data <= {7'b0000000,{2'b00,I_data[9:7]},`FUNC_AND,{2'b00,I_data[9:7]},`OP_AND};
                        end  
                    end
                end
                else if(I_data[15:13] == 3'b101) begin
                    // C.J
                    $display("The current instruction is C.J");
                    O_data <= {I_data[12],{I_data[8],I_data[10:9],I_data[6],I_data[7],I_data[2],I_data[11],I_data[5:3]},I_data[12],{8{I_data[12]}},`X0,`OP_JAL};
                end
                else if(I_data[15:13] == 3'b110) begin
                    // C.BEQZ
                    $display("The current instruction is C.BEQZ");
                    O_data <= {{{3{I_data[12]}},I_data[12],I_data[6:5],I_data[2]},`X0,{2'b00,I_data[9:7]},`FUNC_BEQ,{I_data[11:10],I_data[4:3],1'b0},`OP_BEQ};
                end
                else if(I_data[15:13] == 3'b111) begin
                    // C.BNEZ
                    $display("The current instruction is C.BNEZ");
                    O_data <= {{{3{I_data[12]}},I_data[12],I_data[6:5],I_data[2]},`X0,{2'b00,I_data[9:7]},`FUNC_BNE,{I_data[11:10],I_data[4:3],1'b0},`OP_BNE};
                end                                
                else begin
                    $stop(); 
                end
            end
            else begin
                // Quadrant 2
                $display("Quadrant 2 - 16 bit instruction");
                if(I_data[15:13] == 3'b000) begin
                    // C.SLLI
                    $display("The current instruction is C.SLLI");
                    O_data <= {7'b0000000,I_data[12],I_data[6:2],I_data[11:7],`FUNC_SLLI,I_data[11:7],`OP_SLLI};
                end
                else if(I_data[15:13] == 3'b010) begin
                    // C.LWSP
                    $display("The current instruction is C.LWSP");
                    O_data <= {{4'b0000,I_data[3:2],I_data[12],I_data[6:4],2'b00},`X2,`FUNC_LW,{I_data[11:7]},`OP_LW};
                end
                else if(I_data[15:13] == 3'b100) begin
                    if(I_data[12] == 1'b0) begin
                        if(I_data[6:2] == `ZERO) begin
                            // C.JR
                            $display("The current instruction is C.JR");
                            O_data <= {12'b000000000000,I_data[11:7],`FUNC_JALR,`X0,`OP_JALR};
                        end
                        else begin
                            // C.MV
                            $display("The current instruction is C.MV");
                            O_data <= {7'b0000000,I_data[6:2],`X0,`FUNC_ADD,I_data[11:7],`OP_ADD};                      
                        end
                    end
                    else begin
                        if(I_data[6:2] == `ZERO) begin
                            if(I_data[11:7] == `ZERO) begin
                                // C.EBREAK
                                $display("The current instruction is C.EBREAK");
                                O_data <= {12'b000000000001,`ZERO,`FUNC_EBREAK,`ZERO,`OP_EBREAK};        
                            end
                            else begin
                                // C.JALR
                                $display("The current instruction is C.JALR");
                                O_data <= {12'b000000000000,I_data[11:7],`FUNC_JALR,`X1,`OP_JALR};
                            end
                        end
                        else begin
                            // C.ADD
                            $display("The current instruction is C.ADD");
                            O_data <= {7'b0000000,I_data[6:2],I_data[11:7],`FUNC_ADD,I_data[11:7],`OP_ADD};                        
                        end
                    end
                end
                else if(I_data[15:13] == 3'b110) begin
                    // C.SWSP
                    $display("The current instruction is C.SWSP");
                    O_data <= {{4'b0000,I_data[8:7],I_data[12]},I_data[6:2],`X2,`FUNC_SW,{I_data[11:9],2'b00},`OP_SW};
                end
                else begin
                    $display("Error instruction not found\ %b", I_data);
                    $stop(); 
                end
            end     
        end
    end
endmodule
