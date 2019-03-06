// Written by Jack McEllin - 15170144
// A simple 2 input ALU

`include "alu_definitions.vh"

module privilege #(parameter VECTOR=32'h00000000) (
    input wire I_clk,
    input wire I_rst,

    // Software interrupts
    input wire I_ecall,
    input wire I_ebreak,
    input wire I_illegalinst,

    // Hardware interrupts
    input wire I_extinterrupt,
    
    // MRET Control wire - Used to restore MEIE
    input wire I_mret,
    
    // MSR Read/Write connections
    input wire [31:0] I_pc,
    input wire I_msrwen,
    input wire signed [11:0] I_csraddr,
    input wire signed [3:0] I_rs1addr,
    input wire signed [31:0] I_rs1data,
	output reg signed [31:0] O_csrdata,
	
	// Mux_interrupt select
	output reg O_exception,
	output wire [31:0] O_epcreturn,
	output wire [31:0] O_evect,
	
	// Debug wires
	output reg [2:0] mstatus,     //[31:3] are always zero
    output reg [4:0] mcause,      // [30:4] are always zero
    output reg [31:0] mepc,
    output reg [31:0] mevect
);

    // Connect all interrupt/exception sources together
    wire exception = I_ecall | I_ebreak | I_illegalinst;

    // Connect mepc and mevect to output
    assign O_epcreturn = (mcause[4] == 0) ? mepc + 4 : mepc;       // Point to next instruction if exception
    assign O_evect = mevect;

    // Initialise registers
    initial begin
        mstatus <= 3'b000;
        mcause <= 5'b00000;
        mepc <= 32'h00000000;
        mevect <= VECTOR;
        O_exception <= 0;
    end

//    // On negedge, we will be handling interrupts
//    always @(negedge I_clk) begin
//        // Set exception to zero
//        O_exception <= 0;
           
//        // Check to see if an internal exception has occured (Not affected by MEIE)
//        if(exception) begin
//            // Check which exception occured and store it in MCAUSE
//            if(I_illegalinst) begin
//                $display("PRIV: An illegal instruction exception has occured");
//                mcause <= 5'b00010;
//            end
//            else if (I_ebreak) begin
//                $display("PRIV: An ebreak exception has occured");
//                mcause <= 5'b00011;
//            end
//            else begin // ECALL
//                $display("PRIV: An ecall exception has occured");
//                mcause <= 5'b01011;
//            end
        
//            // Now that mcause is set correctly, we can jump to our ISR
//            // Save PC to EPC.
//            mepc <= I_pc;
                   
//           // Save MEIE to MEIE_PREV
//            mstatus[1] <= mstatus[0];
                   
//            // Set MEIE to zero to prevent further interrupts/exceptions
//            mstatus[0] <= 0;
                   
//            // Set mux_interrupt to set PC to EVECT on next posedge clk
//            O_exception <= 1;
//        end
            
//        // Check if external interrupt has occured and interrupts are enabled
//        else if(I_extinterrupt && (mstatus[0] == 1)) begin
//            $display("PRIV: An external interrupt has occured");
            
//            // State that an external interrupt has occured in MCAUSE
//            mcause <= 5'b11011;        
        
//            // Now that mcause is set correctly, we can jump to our ISR        
//            // Save PC to EPC.
//            mepc <= I_pc;
            
//            // Save MEIE to MEIE_PREV
//            mstatus[1] <= mstatus[0];
            
//            // Set MEIE to zero to prevent further interrupts/exceptions
//            mstatus[0] <= 0;
            
//            // Set mux_interrupt to set PC to EVECT on next posedge clk
//            O_exception <= 1;
//        end
        
//        // Check to see if MRET instruction was called so we can update MEIE
//        else if(I_mret) begin
//            // Set MEIE to previous
//            mstatus[0] <= mstatus[1];
//            $display("MRET: The MRET instruction was called");
//        end
//    end
    
    // On posedge, we will be reading or writing to the MSR registers    
    always @(posedge I_clk) begin
        // Reset registers if reset is enabled
        if(I_rst) begin
            mstatus <= 3'b000;
            mcause <= 5'b00000;
            mepc <= 32'h00000000;
            mevect <= VECTOR;
        end
        
        else begin
            // Let's check to see if an exceptions/interrupts has occured
            O_exception <= 0;
            
            if(exception) begin
                // Check which exception occured and store it in MCAUSE
                if(I_illegalinst) begin
                    $display("PRIV: An illegal instruction exception has occured");
                    mcause <= 5'b00010;
                end
                else if (I_ebreak) begin
                    $display("PRIV: An ebreak exception has occured");
                    mcause <= 5'b00011;
                end
                else begin // ECALL
                    $display("PRIV: An ecall exception has occured");
                    mcause <= 5'b01011;
                end
            
                // Now that mcause is set correctly, we can jump to our ISR
                // Save PC to EPC.
                mepc <= I_pc;
                       
               // Save MEIE to MEIE_PREV
                mstatus[1] <= mstatus[0];
                       
                // Set MEIE to zero to prevent further interrupts/exceptions
                mstatus[0] <= 0;
                       
                // Set mux_interrupt to set PC to EVECT on next posedge clk
                O_exception <= 1;
            end
            
            //Check to see if an interrupt occured
            else if(I_extinterrupt && (mstatus[0] == 1)) begin
                $display("PRIV: An external interrupt has occured");
                        
                // State that an external interrupt has occured in MCAUSE
                mcause <= 5'b11011;        
                    
                // Now that mcause is set correctly, we can jump to our ISR        
                // Save PC to EPC.
                mepc <= I_pc;
                        
                // Save MEIE to MEIE_PREV
                mstatus[1] <= mstatus[0];
                        
                // Set MEIE to zero to prevent further interrupts/exceptions
                mstatus[0] <= 0;
                        
                // Set mux_interrupt to set PC to EVECT on next posedge clk
                O_exception <= 1;
            end
            
            else if(I_mret) begin
                // Set MEIE to previous
                mstatus[0] <= mstatus[1];
                $display("MRET: The MRET instruction was called");
            end
            
            // If there are no exceptions/interrupts, it is save to write to the MSR registers
            // If msrwen is high, then we save I_rs1data to the approiate CSR
            else if (I_msrwen == 1 && (I_rs1addr != 4'b0000)) begin
                case(I_csraddr)              
                    // Read-Write
                    12'h7C0: mstatus <= I_rs1data[2:0];
                    12'h7C1: mcause <= {I_rs1data[31], I_rs1data[3:0]};
                    12'h7C2: mepc <= I_rs1data;
                    12'h7C3: mevect <= I_rs1data;
                endcase
                $display("The value %h was stored in msr %h", I_rs1data, I_csraddr);
            end
        end
    end
    
    // Use combinational logic to place correct MSR value on O_csrdata
    always @(*) begin
        // Output CSR to O_csrdata - Note these values are for write back to registers
        case(I_csraddr)
            12'hFC0: O_csrdata = {29'b00000000000000000000000000000,mstatus};
            12'h7C0: O_csrdata = {29'b00000000000000000000000000000,mstatus};
            12'hFC1: O_csrdata = {mcause[4],27'b00000000000000000000000000000,mcause[3:0]};
            12'h7C1: O_csrdata = {mcause[4],27'b00000000000000000000000000000,mcause[3:0]};
            12'hFC2: O_csrdata = mepc;
            12'h7C2: O_csrdata = mepc;
            12'hFC3: O_csrdata = mevect;
            12'h7C3: O_csrdata = mevect;
            default: O_csrdata = 32'hFFFFFFFF; // This shouldn't be hit under correct use, can use this to check
        endcase
    end
endmodule
