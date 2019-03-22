// A clock divider module
// Written by Jack McEllin - 15170144

module clock_divider #(parameter DIVISOR = 27'd50000000) (
    input wire I_clk,
    output wire O_clk
    );
    
    reg[26:0] counter=27'd0;
    
    always @(posedge I_clk) begin
        counter <= counter + 27'd1;
        if(counter >= (DIVISOR-1)) begin
            counter <= 27'd0;
        end
    end
    
    assign O_clk = (counter < DIVISOR/2) ? 0: 1;

endmodule
