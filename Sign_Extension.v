`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2024 08:22:25 PM
// Design Name: 
// Module Name: Sign_Extension
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


module Sign_Extension(
    input [3:0] Immediate, //immediate from the instruction
    input ImmediateSourceControl,
    output reg [15:0] Immediate_Extension
    );
    
    always @(*) begin
            case(ImmediateSourceControl)
                2'b00: Immediate_Extension = {{12{Immediate[3]}}, Immediate}; // sign-extend immediate (4 to 16 bits)
                2'b01: Immediate_Extension = {{12{1'b0}}, Immediate};  // zero-extend immediate (for load/store offsets if needed)
                default: Immediate_Extension = 16'b0;  // Default case for safety
            endcase
        end
endmodule