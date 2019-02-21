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
            case({I_data[14:12],I_data[6:0]})
                {3'b???,`OP_LUI}:           $display("\nThe current instruction is LUI");
                {3'b???,`OP_AUIPC}:         $display("\nThe current instruction is AUIPC");
                
                {3'b???,`OP_JAL}:           $display("\nThe current instruction is JAL");
                {3'b???,`OP_JALR}:          $display("\nThe current instruction is JALR");
        
                {`FUNC_BEQ,`OP_BEQ}:        $display("\nThe current instruction is BEQ");
                {`FUNC_BNE,`OP_BNE}:        $display("\nThe current instruction is BNE");
                {`FUNC_BLT,`OP_BLT}:        $display("\nThe current instruction is BLT");
                {`FUNC_BGE,`OP_BGE}:        $display("\nThe current instruction is BGE");
                {`FUNC_BLTU,`OP_BLTU}:      $display("\nThe current instruction is BLTU");
                {`FUNC_BLTU,`OP_BGEU}:      $display("\nThe current instruction is BGEU");
        
                {`FUNC_LB,`OP_LB}:          $display("\nThe current instruction is LB");
                {`FUNC_LH,`OP_LH}:          $display("\nThe current instruction is LH");
                {`FUNC_LW,`OP_LW}:          $display("\nThe current instruction is LW");
                {`FUNC_LBU,`OP_LBU}:        $display("\nThe current instruction is LBU");
                {`FUNC_LHU,`OP_LHU}:        $display("\nThe current instruction is LHU");
        
                {`FUNC_SB,`OP_SB}:          $display("\nThe current instruction is SB");
                {`FUNC_SH,`OP_SH}:          $display("\nThe current instruction is SH");
                {`FUNC_SW,`OP_SW}:          $display("\nThe current instruction is SW");
        
                {`FUNC_ADDI,`OP_ADDI}:      $display("\nThe current instruction is ADDI");
                {`FUNC_SLTI,`OP_SLTI}:      $display("\nThe current instruction is SLTI");
                {`FUNC_SLTIU,`OP_SLTIU}:    $display("\nThe current instruction is SLTIU");
                {`FUNC_XORI,`OP_XORI}:      $display("\nThe current instruction is XORI");
                {`FUNC_ORI,`OP_ORI}:        $display("\nThe current instruction is ORI");
                {`FUNC_ANDI,`OP_ANDI}:      $display("\nThe current instruction is ANDI");
                {`FUNC_SLLI,`OP_SLLI}:      $display("\nThe current instruction is SLLI");
                {`FUNC_SRLI,`OP_SRLI}:      $display("\nThe current instruction is SRLI");
                {`FUNC_SRAI,`OP_SRAI}:      $display("\nThe current instruction is SRAI");
        
                {`FUNC_AND,`OP_ADD}:        $display("\nThe current instruction is ADD");
                {`FUNC_SUB,`OP_SUB}:        $display("\nThe current instruction is SUB");
                {`FUNC_SLL,`OP_SLL}:        $display("\nThe current instruction is SLL");
                {`FUNC_SLT,`OP_SLT}:        $display("\nThe current instruction is SLT");
                {`FUNC_SLTU,`OP_SLTU}:      $display("\nThe current instruction is SLT");
                {`FUNC_XOR,`OP_XOR}:        $display("\nThe current instruction is XOR");
                {`FUNC_SRL,`OP_SRL}:        $display("\nThe current instruction is SRL");
                {`FUNC_SRA,`OP_SRA}:        $display("\nThe current instruction is SRA");
                {`FUNC_OR,`OP_OR}:          $display("\nThe current instruction is OR");
                {`FUNC_AND,`OP_AND}:        $display("\nThe current instruction is AND");
        
                {`FUNC_ECALL,`OP_ECALL}:    $display("\nThe current instruction is ECALL");
                {`FUNC_EBREAK,`OP_EBREAK}:  $display("\nThe current instruction is EBREAK");
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
                if(I_data[15:13] == 3'b000) begin
                    // C.ADDI4SPN
                    $display("\nThe current instruction is C.ADDI4SPN");
                    O_data <= {{2'b00,I_data[10:7],I_data[12:11],I_data[5],I_data[6],2'b00},`X2,`FUNC_ADDI,{2'b01,I_data[4:2]},`OP_ADDI};
                end
                else if(I_data[15:13] == 3'b010) begin
                    // C.LW
                    $display("\nThe current instruction is C.LW");
                    O_data <= {{5'b00000,I_data[5],I_data[12:10],I_data[6],2'b00},{2'b01,I_data[9:7]},`FUNC_LW,{2'b01,I_data[4:2]},`OP_LW};
                end
                else if(I_data[15:13] == 3'b110) begin
                    // C.SW
                    $display("\nThe current instruction is C.SW");
                    O_data <= {{5'b00000,I_data[5],I_data[12]},{2'b01,I_data[4:2]},{2'b01,I_data[9:7]},`FUNC_SW,{I_data[11:10],I_data[6],2'b00},`OP_SW};
                end                
                else begin
                    $stop(); 
                end
                $display("Quadrant 0 - 16 bit instruction"); 
            end
            else if(I_data[1:0] == 2'b01) begin
                // Quadrant 1
                if(I_data[15:13] == 3'b000) begin
                    // C.NOP / C.ADDI
                    $display("\nThe current instruction is C.ADDI");
                    O_data <= {{{6{I_data[12]}},I_data[12],I_data[6:2]},I_data[11:7],`FUNC_ADDI,I_data[11:7],`OP_ADDI};
                end
                else if(I_data[15:13] == 3'b001) begin
                    // C.JAL
                    $display("\nThe current instruction is C.JAL");
                    O_data <= {I_data[12],{I_data[8],I_data[10:9],I_data[6],I_data[7],I_data[2],I_data[11],I_data[5:3]},I_data[12],{8{I_data[12]}},`X1,`OP_JAL};
                end
                else if(I_data[15:13] == 3'b010) begin
                    // C.LI
                    $display("\nThe current instruction is C.LI");
                    O_data <= {{{6{I_data[12]}},I_data[12],I_data[6:2]},`X0,`FUNC_ADDI,I_data[11:7],`OP_ADDI};
                end
                else if(I_data[15:13] == 3'b011) begin
                    if(I_data[11:7] == `X2) begin
                        // C.ADDI16SP
                        $display("\nThe current instruction is C.ADDI16SP");
                        O_data <= {{{2{I_data[12]}},I_data[12],I_data[4:3],I_data[5],I_data[2],I_data[6],4'b0000},`X2,`FUNC_ADDI,`X2,`OP_ADDI};
                    end
                    else begin
                        // C.LUI
                        $display("\nThe current instruction is C.LUI");
                        O_data <= {{{2{I_data[12]}},I_data[12],I_data[6:2],12'b000000000000},I_data[11:7],`OP_LUI};
                    end
                end
                else if(I_data[15:13] == 3'b100) begin
                    if(I_data[11:10] == 2'b00) begin
                        // C.SRLI
                        $display("\nThe current instruction is C.SRLI");
                        O_data <= {7'b0000000,I_data[6:2],{2'b01,I_data[9:7]},`FUNC_SRLI,{2'b01,I_data[9:7]},`OP_SRLI};
                    end
                    else if(I_data[11:10] == 2'b01) begin
                        // C.SRAI
                        $display("\nThe current instruction is C.SRAI");
                        O_data <= {7'b0100000,I_data[6:2],{2'b01,I_data[9:7]},`FUNC_SRAI,{2'b01,I_data[9:7]},`OP_SRAI};
                    end
                    else if(I_data[11:10] == 2'b10) begin
                        // C.ANDI
                        $display("\nThe current instruction is C.ANDI");
                        O_data <= {{{6{I_data[12]}},I_data[12],I_data[6:2]},{2'b01,I_data[9:7]},`FUNC_ANDI,{2'b01,I_data[9:7]},`OP_ANDI};
                    end
                    else begin
                        if(I_data[6:5] == 2'b00) begin
                            // C.SUB
                            $display("\nThe current instruction is C.SUB");
                            O_data <= {7'b0100000,{2'b01,I_data[9:7]},`FUNC_SUB,{2'b01,I_data[9:7]},`OP_SUB};
                        end 
                        else if(I_data[6:5] == 2'b00) begin
                            // C.XOR
                            $display("\nThe current instruction is C.XOR");
                            O_data <= {7'b0000000,{2'b01,I_data[9:7]},`FUNC_XOR,{2'b01,I_data[9:7]},`OP_XOR};
                        end  
                        else if(I_data[6:5] == 2'b00) begin
                            // C.OR
                            $display("\nThe current instruction is C.OR");
                            O_data <= {7'b0000000,{2'b01,I_data[9:7]},`FUNC_OR,{2'b01,I_data[9:7]},`OP_OR};
                        end 
                        else begin
                            // C.AND
                            $display("\nThe current instruction is C.AND");
                            O_data <= {7'b0000000,{2'b01,I_data[9:7]},`FUNC_AND,{2'b01,I_data[9:7]},`OP_AND};
                        end  
                    end
                end
                else if(I_data[15:13] == 3'b101) begin
                    // C.J
                    $display("\nThe current instruction is C.J");
                    O_data <= {I_data[12],{I_data[8],I_data[10:9],I_data[6],I_data[7],I_data[2],I_data[11],I_data[5:3]},I_data[12],{8{I_data[12]}},`X0,`OP_JAL};
                end
                else if(I_data[15:13] == 3'b110) begin
                    // C.BEQZ
                    $display("\nThe current instruction is C.BEQZ");
                    O_data <= {{{3{I_data[12]}},I_data[12],I_data[6:5],I_data[2]},`X0,{2'b01,I_data[9:7]},`FUNC_BEQ,{I_data[11:10],I_data[4:3],1'b0},`OP_BEQ};
                end
                else if(I_data[15:13] == 3'b111) begin
                    // C.BNEZ
                    $display("\nThe current instruction is C.BNEZ");
                    O_data <= {{{3{I_data[12]}},I_data[12],I_data[6:5],I_data[2]},`X0,{2'b01,I_data[9:7]},`FUNC_BNE,{I_data[11:10],I_data[4:3],1'b0},`OP_BNE};
                end                                
                else begin
                    $stop(); 
                end
                $display("Quadrant 1 - 16 bit instruction");
            end
            else begin
                // Quadrant 2
                if(I_data[15:13] == 3'b000) begin
                    // C.SLLI
                    $display("\nThe current instruction is C.SLLI");
                    O_data <= {7'b0000000,I_data[12],I_data[6:2],I_data[11:7],`FUNC_SLLI,I_data[11:7],`OP_SLLI};
                end
                else if(I_data[15:13] == 3'b010) begin
                    // C.LWSP
                    $display("\nThe current instruction is C.LWSP");
                    O_data <= {{4'b0000,I_data[3:2],I_data[12],I_data[6:4],2'b00},`X2,`FUNC_LW,{I_data[11:7]},`OP_LW};
                end
                else if(I_data[15:13] == 3'b100) begin
                    if(I_data[12] == 1'b0) begin
                        if(I_data[6:2] == `ZERO) begin
                            // C.JR
                            $display("\nThe current instruction is C.JR");
                            O_data <= {12'b000000000000,I_data[11:7],`FUNC_JALR,`X0,`OP_JALR};
                        end
                        else begin
                            // C.MV
                            $display("\nThe current instruction is C.MV");
                            O_data <= {7'b0000000,I_data[6:2],`X0,`FUNC_ADD,I_data[11:7],`OP_ADD};                      
                        end
                    end
                    else begin
                        if(I_data[6:2] == `ZERO) begin
                            if(I_data[11:7] == `ZERO) begin
                                // C.EBREAK
                                $display("\nThe current instruction is C.EBREAK");
                                O_data <= {12'b000000000001,`ZERO,`FUNC_EBREAK,`ZERO,`OP_EBREAK};        
                            end
                            else begin
                                // C.JALR
                                $display("\nThe current instruction is C.JALR");
                                O_data <= {12'b000000000000,I_data[11:7],`FUNC_JALR,`X1,`OP_JALR};
                            end
                        end
                        else begin
                            // C.ADD
                            $display("\nThe current instruction is C.ADD");
                            O_data <= {7'b0000000,I_data[6:2],I_data[11:7],`FUNC_ADD,I_data[11:7],`OP_ADD};                        
                        end
                    end
                end
                else if(I_data[15:13] == 3'b110) begin
                    // C.SWSP
                    $display("\nThe current instruction is C.SWSP");
                    O_data <= {{4'b0000,I_data[8:7],I_data[12]},I_data[6:2],`X2,`FUNC_SW,{I_data[11:9],2'b00},`OP_SW};
                end
                else begin
                    $display("\nError instruction not found\ %b", I_data);
                    $stop(); 
                end
                $display("Quadrant 2 - 16 bit instruction");
            end     
        end
    end
endmodule
