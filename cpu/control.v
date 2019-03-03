`include "control_definitions.vh"

module control(
    input wire [10:0] I_control,
    input wire I_breq,
    input wire I_brlt,
    
    // Exception Flags
    output reg O_ecall,
    output reg O_ebreak,
    output reg O_illegalinst,
    
    // Standard Control Wires
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
    output wire [1:0] O_storesel,
    
    // Privileged Control Wires
    output wire O_privsel,
    output wire O_msrwen,
    output wire O_csrwbsel
    );
    
    // Register to store the current contol value
    reg [22:0] control_reg;
    
    // Wire O_control to output pins    
    assign O_pcsel = control_reg[22];
    assign O_immsel = control_reg[21:19];
    assign O_brun = control_reg[18];
    assign O_asel = control_reg[17];
    assign O_bsel = control_reg[16];
    assign O_alusel = control_reg[15:12];
    assign O_memrw = control_reg[11];
    assign O_regwen = control_reg[10];
    assign O_loadsel = control_reg[9:7];
    assign O_storesel = control_reg[6:5];
    assign O_wbsel = control_reg[4:3];
    assign O_privsel = control_reg[2];
    assign O_msrwen = control_reg[1];
    assign O_csrwbsel = control_reg[0]; 

    always @(*) begin
        // Reset flags
        O_ecall <= 0;
        O_ebreak <= 0;
        O_illegalinst <= 0;
    
        // Figure out what instruction it is
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
            `CONTROL_IN_ECALL:      O_ecall <= 1;
            `CONTROL_IN_EBREAK:     O_ebreak <= 1;
            
            // Opcodes - Interrupts
            `CONTROL_IN_CSRRW:      control_reg <= `CONTROL_OUT_CSRRW;    //CSRRW
            `CONTROL_IN_MRET:       control_reg <= `CONTROL_OUT_MRET;   //MRET    
                                    
            default:  O_illegalinst <= 1;   // Set Illegal Instruction flag to 1
        endcase
    end
    

endmodule
