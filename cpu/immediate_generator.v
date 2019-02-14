module immediate_generator(
    input wire [2:0] I_immsel,
    input wire [31:0] I_data,
    output reg [31:0] O_data
    );
    
    always @(*) begin
        casez(I_data)
            3'b000: ;
            default: ;
        endcase
    end
    
endmodule
