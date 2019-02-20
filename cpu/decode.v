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
                    O_data <= {{2'b00,I_data[10:7],I_data[12:11],I_data[5],I_data[6],2'b00},`X2,`FUNC_ADDI,{2'b00,I_data[4:2]},`OP_ADDI};
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
                    O_data <= {{6'b000000,I_data[12],I_data[6:2]},I_data[11:7],`FUNC_ADDI,I_data[11:7],`OP_ADDI};
                end
                else if(I_data[15:13] == 3'b001) begin
                    // C.JAL
                    $display("The current instruction is C.JAL");
                    O_data <= {{6'b000000,I_data[12],I_data[6:2]},I_data[11:7],`FUNC_ADDI,I_data[11:7],`OP_JAL};
                end
                else begin
                    $stop(); 
                end
            end
            else begin
                // Quadrant 2
                $display("Quadrant 2 - 16 bit instruction");
                
                if(I_data[15:13] == 3'b110) begin
                    // C.SWSP
                    $display("The current instruction is C.SWSP");
                    O_data <= {{4'b0000,I_data[8:7],I_data[12]},I_data[6:2],`X2,`FUNC_SW,{I_data[11:9],2'b00},`OP_SW};
                end
                else begin
                    $stop(); 
                end
            end     
        end
    end
    
//    wire [9:0] control = {I_data[30],I_data[20],I_data[14:12],I_data[6:2],2'b00};
//    always @(*) begin
//        casez(control) // 2'00 used here so it only prints the current instruction once
//            // Opcodes - Upper Immediates
//            `CONTROL_IN_LUI:        $display("The current instruction is LUI");             //LUI
//            `CONTROL_IN_AUIPC:      $display("The current instruction is AUIPC");           //AUIPC
                                                  
//            // Opcodes - Jumps                         
//            `CONTROL_IN_JAL:        $display("The current instruction is JAL");             //JAL
//            `CONTROL_IN_JALR:       $display("The current instruction is JALR");            //JALR
                                                  
//            // Opcodes - Branches                      
//            `CONTROL_IN_BEQ_TRUE:   $display("The current instruction is BEQ_TRUE");        //BEQ
//            `CONTROL_IN_BNE_TRUE:   $display("The current instruction is BNE_TRUE");        //BNE
//            `CONTROL_IN_BLT_TRUE:   $display("The current instruction is BLT_TRUE");        //BLT
//            `CONTROL_IN_BGE_TRUE:   $display("The current instruction is BGE_TRUE");        //BGE
//            `CONTROL_IN_BLTU_TRUE:  $display("The current instruction is BLTU_TRUE");       //BLTU
//            `CONTROL_IN_BGEU_TRUE:  $display("The current instruction is BGEU_TRUE");       //BGEU
    
//            // Opcodes - Branches                                                       
//            `CONTROL_IN_BEQ_FALSE:  $display("The current instruction is BEQ_FALSE");       //BEQ 
//            `CONTROL_IN_BNE_FALSE:  $display("The current instruction is BNE_FALSE");       //BNE 
//            `CONTROL_IN_BLT_FALSE:  $display("The current instruction is BLT_FALSE");       //BLT 
//            `CONTROL_IN_BGE_FALSE:  $display("The current instruction is BGE_FALSE");       //BGE 
//            `CONTROL_IN_BLTU_FALSE: $display("The current instruction is BLTU_FALSE");      //BLTU
//            `CONTROL_IN_BGEU_FALSE: $display("The current instruction is BGEU_FALSE");      //BGEU
                                                
//            // Opcodes - Loads                         
//            `CONTROL_IN_LB:         $display("The current instruction is LB");              //LB  
//            `CONTROL_IN_LH:         $display("The current instruction is LH");              //LH  
//            `CONTROL_IN_LW:         $display("The current instruction is LW");              //LW  
//            `CONTROL_IN_LBU:        $display("The current instruction is LBU");             //LBU
//            `CONTROL_IN_LHU:        $display("The current instruction is LHU");             //LHU
                                                  
//            // Opcodes - Stores                        
//            `CONTROL_IN_SB:         $display("The current instruction is SB");              //SB  
//            `CONTROL_IN_SH:         $display("The current instruction is SH");              //SH  
//            `CONTROL_IN_SW:         $display("The current instruction is SW");              //SW  
                                                  
//            // Opcodes - Register <-> Immediate        
//            `CONTROL_IN_ADDI:       $display("The current instruction is ADDI");            //ADDI
//            `CONTROL_IN_SLTI:       $display("The current instruction is SLTI");            //SLTI
//            `CONTROL_IN_SLTIU:      $display("The current instruction is SLTIU");           //SLTIU
//            `CONTROL_IN_XORI:       $display("The current instruction is XORI");            //XORI
//            `CONTROL_IN_ORI:        $display("The current instruction is ORI");             //ORI
//            `CONTROL_IN_ANDI:       $display("The current instruction is ANDI");            //ANDI
//            `CONTROL_IN_SLLI:       $display("The current instruction is SLLI");            //SLLI
//            `CONTROL_IN_SRLI:       $display("The current instruction is SRLI");            //SRLI
//            `CONTROL_IN_SRAI:       $display("The current instruction is SRAI");            //SRAI
                                                  
//            // Opcodes - Register <-> Register         
//            `CONTROL_IN_ADD:        $display("The current instruction is ADD");             //ADD
//            `CONTROL_IN_SUB:        $display("The current instruction is SUB");             //SUB
//            `CONTROL_IN_SLL:        $display("The current instruction is SLL");             //SLL
//            `CONTROL_IN_SLT:        $display("The current instruction is SLT");             //SLT
//            `CONTROL_IN_SLTU:       $display("The current instruction is SLT");             //SLTU
//            `CONTROL_IN_XOR:        $display("The current instruction is XOR");             //XOR
//            `CONTROL_IN_SRL:        $display("The current instruction is SRL");             //SRL
//            `CONTROL_IN_SRA:        $display("The current instruction is SRA");             //SRA
//            `CONTROL_IN_OR:         $display("The current instruction is OR");              //OR  
//            `CONTROL_IN_AND:        $display("The current instruction is AND");             //AND    
            
//            // Opcodes - Register <-> Register         
//            `CONTROL_IN_ECALL:     $display("The current instruction is ECALL");           //ECALL   
//            `CONTROL_IN_EBREAK:    $display("The current instruction is EBREAK");          //EBREAK   
             
//            default: $display("ERROR: INSTRUCTION NOT FOUND"); //Defaults to ADDI - Change this
//        endcase
//    end
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
