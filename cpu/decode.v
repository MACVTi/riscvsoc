// Include opcodes for compressed instructions
`include "control.vh"

module decode(
    input wire I_clk,
    input wire [31:0] I_data,
    input wire  I_breq,
    input wire  I_brlt,
    output wire [31:0] O_pcincr,
    output wire [31:0] O_data
    );

    assign O_pcincr = 32'h00000004;
    assign O_data = I_data;
    
    always @(*) begin
        if(O_data == 32'h00000000) begin
            $stop();
        end
    end
    
    wire [8:0] I_control;
    assign I_control = {O_data[30],O_data[14:12],O_data[6:2]};

    always @(posedge I_clk) begin
         casez({I_control, I_breq, I_brlt})
         // Opcodes - Upper Immediates
         `CONTROL_IN_LUI:        $display("The current instruction is LUI: %b", {I_control, I_breq, I_brlt});       //LUI
         `CONTROL_IN_AUIPC:      $display("The current instruction is AUIPC: %b", {I_control, I_breq, I_brlt});     //AUIPC
                                                 
         // Opcodes - Jumps                         
         `CONTROL_IN_JAL:        $display("The current instruction is JAL: %b", {I_control, I_breq, I_brlt});       //JAL
         `CONTROL_IN_JALR:       $display("The current instruction is JALR: %b", {I_control, I_breq, I_brlt});      //JALR
                                                 
         // Opcodes - Branches                      
         `CONTROL_IN_BEQ_TRUE:   $display("The current instruction is BEQ_TRUE: %b", {I_control, I_breq, I_brlt});     //BEQ
         `CONTROL_IN_BNE_TRUE:   $display("The current instruction is BNE_TRUE: %b", {I_control, I_breq, I_brlt});     //BNE
         `CONTROL_IN_BLT_TRUE:   $display("The current instruction is BLT_TRUE: %b", {I_control, I_breq, I_brlt});     //BLT
         `CONTROL_IN_BGE_TRUE:   $display("The current instruction is BGE_TRUE: %b", {I_control, I_breq, I_brlt});     //BGE
         `CONTROL_IN_BLTU_TRUE:  $display("The current instruction is BLTU_TRUE: %b", {I_control, I_breq, I_brlt});    //BLTU
         `CONTROL_IN_BGEU_TRUE:  $display("The current instruction is BGEU_TRUE: %b", {I_control, I_breq, I_brlt});    //BGEU
    
         // Opcodes - Branches                                                       
         `CONTROL_IN_BEQ_FALSE:  $display("The current instruction is BEQ_FALSE: %b", {I_control, I_breq, I_brlt});    //BEQ 
         `CONTROL_IN_BNE_FALSE:  $display("The current instruction is BNE_FALSE: %b", {I_control, I_breq, I_brlt});    //BNE 
         `CONTROL_IN_BLT_FALSE:  $display("The current instruction is BLT_FALSE: %b", {I_control, I_breq, I_brlt});    //BLT 
         `CONTROL_IN_BGE_FALSE:  $display("The current instruction is BGE_FALSE: %b", {I_control, I_breq, I_brlt});    //BGE 
         `CONTROL_IN_BLTU_FALSE: $display("The current instruction is BLTU_FALSE: %b", {I_control, I_breq, I_brlt});   //BLTU
         `CONTROL_IN_BGEU_FALSE: $display("The current instruction is BGEU_FALSE: %b", {I_control, I_breq, I_brlt});   //BGEU
                                               
         // Opcodes - Loads                         
         `CONTROL_IN_LB:         $display("The current instruction is LB: %b", {I_control, I_breq, I_brlt});    //LB  
         `CONTROL_IN_LH:         $display("The current instruction is LH: %b", {I_control, I_breq, I_brlt});    //LH  
         `CONTROL_IN_LW:         $display("The current instruction is LW: %b", {I_control, I_breq, I_brlt});    //LW  
         `CONTROL_IN_LBU:        $display("The current instruction is LBU: %b", {I_control, I_breq, I_brlt});   //LBU
         `CONTROL_IN_LHU:        $display("The current instruction is LHU: %b", {I_control, I_breq, I_brlt});   //LHU
                                                 
         // Opcodes - Stores                        
         `CONTROL_IN_SB:         $display("The current instruction is SB: %b", {I_control, I_breq, I_brlt});    //SB  
         `CONTROL_IN_SH:         $display("The current instruction is SH: %b", {I_control, I_breq, I_brlt});    //SH  
         `CONTROL_IN_SW:         $display("The current instruction is SW: %b", {I_control, I_breq, I_brlt});    //SW  
                                                 
         // Opcodes - Register <-> Immediate        
         `CONTROL_IN_ADDI:       $display("The current instruction is ADDI: %b", {I_control, I_breq, I_brlt});  //ADDI
         `CONTROL_IN_SLTI:       $display("The current instruction is SLTI: %b", {I_control, I_breq, I_brlt});  //SLTI
         `CONTROL_IN_SLTIU:      $display("The current instruction is SLTIU: %b", {I_control, I_breq, I_brlt}); //SLTIU
         `CONTROL_IN_XORI:       $display("The current instruction is XORI: %b", {I_control, I_breq, I_brlt});  //XORI
         `CONTROL_IN_ORI:        $display("The current instruction is ORI: %b", {I_control, I_breq, I_brlt});   //ORI
         `CONTROL_IN_ANDI:       $display("The current instruction is ANDI: %b", {I_control, I_breq, I_brlt});  //ANDI
         `CONTROL_IN_SLLI:       $display("The current instruction is SLLI: %b", {I_control, I_breq, I_brlt});  //SLLI
         `CONTROL_IN_SRLI:       $display("The current instruction is SRLI: %b", {I_control, I_breq, I_brlt});  //SRLI
         `CONTROL_IN_SRAI:       $display("The current instruction is SRAI: %b", {I_control, I_breq, I_brlt});   //SRAI
                                                 
         // Opcodes - Register <-> Register         
         `CONTROL_IN_ADD:        $display("The current instruction is ADD: %b", {I_control, I_breq, I_brlt});   //ADD
         `CONTROL_IN_SUB:        $display("The current instruction is SUB: %b", {I_control, I_breq, I_brlt});   //SUB
         `CONTROL_IN_SLL:        $display("The current instruction is SLL: %b", {I_control, I_breq, I_brlt});   //SLL
         `CONTROL_IN_SLT:        $display("The current instruction is SLT: %b", {I_control, I_breq, I_brlt});   //SLT
         `CONTROL_IN_SLTU:       $display("The current instruction is SLTU: %b", {I_control, I_breq, I_brlt});  //SLTU
         `CONTROL_IN_XOR:        $display("The current instruction is XOR: %b", {I_control, I_breq, I_brlt});   //XOR
         `CONTROL_IN_SRL:        $display("The current instruction is SRL: %b", {I_control, I_breq, I_brlt});   //SRL
         `CONTROL_IN_SRA:        $display("The current instruction is SRA: %b", {I_control, I_breq, I_brlt});   //SRA
         `CONTROL_IN_OR:         $display("The current instruction is OR: %b", {I_control, I_breq, I_brlt});    //OR  
         `CONTROL_IN_AND:        $display("The current instruction is AND: %b", {I_control, I_breq, I_brlt});   //AND    
         
         default: $display("ERROR: INSTRUCTION NOT FOUND: %b", {I_control, I_breq, I_brlt}); //Defaults to ADDI - Change this
         endcase
     end
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
