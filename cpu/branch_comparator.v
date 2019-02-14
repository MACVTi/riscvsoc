module branch_comparator(
        input wire I_branch_unsigned,
        input wire [31:0] I_data1,
        input wire [31:0] I_data2,
        output wire O_branch_equal,
        output wire O_branch_lessthan
    );
    
    assign O_branch_equal = I_data1 === I_data2;
    assign O_branch_lessthan = I_branch_unsigned ? I_data1 < I_data2 : $signed(I_data1) < $signed(I_data2);
    
endmodule
