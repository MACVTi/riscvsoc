`include "control.vh"

module control(
    input wire [9:0] I_control,
    input wire I_breq,
    input wire I_brlt,
    
    output wire O_pcsel,
    output wire [2:0] O_immsel,
    output wire O_regwen,
    output wire O_brun,
    output wire O_asel,
    output wire O_bsel,
    output wire [3:0] O_alusel,
    output wire O_memrw,
    output wire [1:0] O_wbsel,
    output wire [2:0] O_loadsel,
    output wire [1:0] O_storesel
    );
    
    // Register to store the current contol value
    reg [19:0] control_reg;
    
    // Wire O_control to output pins    
    assign O_pcsel = control_reg[19];
    assign O_immsel = control_reg[18:16];
    assign O_brun = control_reg[15];
    assign O_asel = control_reg[14];
    assign O_bsel = control_reg[13];
    assign O_alusel = control_reg[12:9];
    assign O_memrw = control_reg[8];
    assign O_regwen = control_reg[7];
    assign O_loadsel = control_reg[6:4];
    assign O_storesel = control_reg[3:2];
    assign O_wbsel = control_reg[1:0]; 

//    always @(I_control) begin
//        casez({I_control, 2'b00}) // 2'00 used here so it only prints the current instruction once
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
             
//            default: $display("ERROR: INSTRUCTION NOT FOUND: %b", {I_control, I_breq, I_brlt}); //Defaults to ADDI - Change this
//        endcase
//    end
    
    always @(*) begin
        casez({I_control, I_breq, I_brlt})
            // Opcodes - Upper Immediates
            `CONTROL_IN_LUI:        control_reg <= `CONTROL_OUT_LUI;    //LUI
            `CONTROL_IN_AUIPC:      control_reg <= `CONTROL_OUT_AUIPC;    //AUIPC
                                                    
            // Opcodes - Jumps                         
            `CONTROL_IN_JAL:        control_reg <= `CONTROL_OUT_JAL;    //JAL
            `CONTROL_IN_JALR:       control_reg <= `CONTROL_OUT_JALR;    //JALR
                                                    
            // Opcodes - Branches                      
            `CONTROL_IN_BEQ_TRUE:   control_reg <= `CONTROL_OUT_BEQ_TRUE;    //BEQ
            `CONTROL_IN_BNE_TRUE:   control_reg <= `CONTROL_OUT_BNE_TRUE;    //BNE
            `CONTROL_IN_BLT_TRUE:   control_reg <= `CONTROL_OUT_BLT_TRUE;    //BLT
            `CONTROL_IN_BGE_TRUE:   control_reg <= `CONTROL_OUT_BGE_TRUE;    //BGE
            `CONTROL_IN_BLTU_TRUE:  control_reg <= `CONTROL_OUT_BLTU_TRUE;   //BLTU
            `CONTROL_IN_BGEU_TRUE:  control_reg <= `CONTROL_OUT_BGEU_TRUE;   //BGEU

            // Opcodes - Branches                                                       
            `CONTROL_IN_BEQ_FALSE:  control_reg <= `CONTROL_OUT_BEQ_FALSE;    //BEQ 
            `CONTROL_IN_BNE_FALSE:  control_reg <= `CONTROL_OUT_BNE_FALSE;    //BNE 
            `CONTROL_IN_BLT_FALSE:  control_reg <= `CONTROL_OUT_BLT_FALSE;    //BLT 
            `CONTROL_IN_BGE_FALSE:  control_reg <= `CONTROL_OUT_BGE_FALSE;    //BGE 
            `CONTROL_IN_BLTU_FALSE: control_reg <= `CONTROL_OUT_BLTU_FALSE;   //BLTU
            `CONTROL_IN_BGEU_FALSE: control_reg <= `CONTROL_OUT_BGEU_FALSE;   //BGEU
                                                  
            // Opcodes - Loads                         
            `CONTROL_IN_LB:         control_reg <= `CONTROL_OUT_LB;     //LB  
            `CONTROL_IN_LH:         control_reg <= `CONTROL_OUT_LH;     //LH  
            `CONTROL_IN_LW:         control_reg <= `CONTROL_OUT_LW;     //LW  
            `CONTROL_IN_LBU:        control_reg <= `CONTROL_OUT_LBU;    //LBU
            `CONTROL_IN_LHU:        control_reg <= `CONTROL_OUT_LHU;    //LHU
                                                    
            // Opcodes - Stores                        
            `CONTROL_IN_SB:         control_reg <= `CONTROL_OUT_SB;     //SB  
            `CONTROL_IN_SH:         control_reg <= `CONTROL_OUT_SH;     //SH  
            `CONTROL_IN_SW:         control_reg <= `CONTROL_OUT_SW;     //SW  
                                                    
            // Opcodes - Register <-> Immediate        
            `CONTROL_IN_ADDI:       control_reg <= `CONTROL_OUT_ADDI;   //ADDI
            `CONTROL_IN_SLTI:       control_reg <= `CONTROL_OUT_SLTI;   //SLTI
            `CONTROL_IN_SLTIU:      control_reg <= `CONTROL_OUT_SLTIU;  //SLTIU
            `CONTROL_IN_XORI:       control_reg <= `CONTROL_OUT_XORI;   //XORI
            `CONTROL_IN_ORI:        control_reg <= `CONTROL_OUT_ORI;    //ORI
            `CONTROL_IN_ANDI:       control_reg <= `CONTROL_OUT_ANDI;   //ANDI
            `CONTROL_IN_SLLI:       control_reg <= `CONTROL_OUT_SLLI;   //SLLI
            `CONTROL_IN_SRLI:       control_reg <= `CONTROL_OUT_SRLI;   //SRLI
            `CONTROL_IN_SRAI:       control_reg <= `CONTROL_OUT_SRAI;    //SRAI
                                                    
            // Opcodes - Register <-> Register         
            `CONTROL_IN_ADD:        control_reg <= `CONTROL_OUT_ADD;    //ADD
            `CONTROL_IN_SUB:        control_reg <= `CONTROL_OUT_SUB;    //SUB
            `CONTROL_IN_SLL:        control_reg <= `CONTROL_OUT_SLL;    //SLL
            `CONTROL_IN_SLT:        control_reg <= `CONTROL_OUT_SLT;    //SLT
            `CONTROL_IN_SLTU:       control_reg <= `CONTROL_OUT_SLTU;   //SLTU
            `CONTROL_IN_XOR:        control_reg <= `CONTROL_OUT_XOR;    //XOR
            `CONTROL_IN_SRL:        control_reg <= `CONTROL_OUT_SRL;    //SRL
            `CONTROL_IN_SRA:        control_reg <= `CONTROL_OUT_SRA;    //SRA
            `CONTROL_IN_OR:         control_reg <= `CONTROL_OUT_OR;     //OR  
            `CONTROL_IN_AND:        control_reg <= `CONTROL_OUT_AND;    //AND    
            
            // Opcodes - Enviroment Calls
            `CONTROL_IN_ECALL:      $stop();
            `CONTROL_IN_EBREAK:     $stop();
                                    
            default:  control_reg <= 20'h00000;//Defaults to ADDI - Change this
        endcase
    end
    

endmodule
