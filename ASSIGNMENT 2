`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.12.2024 03:18:37
// Design Name: 
// Module Name: home_automation
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module home_automation (
    input motion,       
    input dark,         
    input [2:0] color_select, 
    output reg [4:0] lamp 
);

   
    parameter BLUE   = 5'b00001;
    parameter RED    = 5'b00010;
    parameter GREEN  = 5'b00100;
    parameter YELLOW = 5'b01000;
    parameter WHITE  = 5'b10000;
    parameter OFF    = 5'b00000; 

    
    always @(*) begin
        if (motion && dark) begin 
            case (color_select)
                3'b000: lamp = BLUE;   
                3'b001: lamp = RED;   
                3'b010: lamp = GREEN;  
                3'b011: lamp = YELLOW; 
                3'b100: lamp = WHITE;  
                default: lamp = OFF;   
            endcase
        end else begin
            lamp = OFF; 
        end
    end

endmodule

