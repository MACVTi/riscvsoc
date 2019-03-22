module seg_wishbone #(parameter CLOCKFREQ=1000000000)(
	// Wishbone Bus Connections
	input wire CLK_I,
	input wire RST_I,
	input wire [31:0] DAT_I,
	input wire STB_I,
	input wire WE_I,
    output wire [31:0] DAT_O,
	
	// Nexys 4 DDR connection wires
	output reg [6:0] O_cathode,    //DP is not connected
	output reg [7:0] O_anode
    );
    
    assign DAT_O = current_number;
    
    //Store current number to be displayed
    reg [31:0] current_number;
    
    // Use a counter
    reg [17:0] refresh_counter;
    reg [3:0] LED_BCD;
    wire [2:0] LED_activating_counter;
    
    // This needs to be set to give a refresh rate of around 2ms
    // 25Mhz / 500hz = 2000 -> 2048
    assign LED_activating_counter = refresh_counter[17:15];
   
     // Set initial number to display - My Student ID
     initial begin
        current_number = 32'h15170144;
     end
    
     always @(posedge CLK_I) begin 
         if(RST_I==1) begin
             refresh_counter <= 0;
             O_anode <= 8'b11111111;
         end
         else begin
             refresh_counter <= refresh_counter + 1;
             
             case(LED_activating_counter)
                3'b000: begin
                            O_anode <= 8'b11111110;
                            LED_BCD <= current_number[3:0];
                end
                3'b001: begin
                            O_anode <= 8'b11111101;
                            LED_BCD <= current_number[7:4];
                        end
                3'b010: begin
                            O_anode <= 8'b11111011;
                            LED_BCD <= current_number[11:8];
                        end
                3'b011: begin
                            O_anode <= 8'b11110111;
                            LED_BCD <= current_number[15:12];
                        end
                3'b100: begin
                            O_anode <= 8'b11101111;
                            LED_BCD <= current_number[19:16];
                        end
                3'b101: begin
                            O_anode <= 8'b11011111;
                            LED_BCD <= current_number[23:20];
                        end
                3'b110: begin
                            O_anode <= 8'b10111111;
                            LED_BCD <= current_number[27:24];
                        end
                3'b111: begin
                            O_anode <= 8'b01111111;
                            LED_BCD <= current_number[31:28];
                        end
                default: begin
                            O_anode <= 8'b11111110;
                            LED_BCD <= current_number[3:0];
                         end               
             endcase
         end
     end 
    
    // Cathode patterns of the 7-segment LED display 
    always @(*) begin
        case(LED_BCD)
        4'h0: O_cathode = 7'b0000001; // "0"     
        4'h1: O_cathode = 7'b1001111; // "1" 
        4'h2: O_cathode = 7'b0010010; // "2" 
        4'h3: O_cathode = 7'b0000110; // "3" 
        4'h4: O_cathode = 7'b1001100; // "4" 
        4'h5: O_cathode = 7'b0100100; // "5" 
        4'h6: O_cathode = 7'b0100000; // "6" 
        4'h7: O_cathode = 7'b0001111; // "7" 
        4'h8: O_cathode = 7'b0000000; // "8"     
        4'h9: O_cathode = 7'b0000100; // "9"
        4'hA: O_cathode = 7'b0001000; // "A" 
        4'hB: O_cathode = 7'b1100000; // "B" 
        4'hC: O_cathode = 7'b0110001; // "C" 
        4'hD: O_cathode = 7'b1000010; // "D" 
        4'hE: O_cathode = 7'b0110000; // "E"
        4'hF: O_cathode = 7'b0111000; // "F" 
        default: O_cathode = 7'b0000001; // "0"
        endcase
    end
    
    // Allow writing to display
    always @ (posedge CLK_I) begin
        if (STB_I) begin
            if (WE_I) begin
                current_number <= DAT_I[31:0];
            end
        end
    end
endmodule
