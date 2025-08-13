`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2024 08:07:03 PM
// Design Name: 
// Module Name: PC
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


module PC(
    input clk, rst, 
    input [15:0] PC_Next,
    output reg [15:0] PC
    );
    
    always @(posedge clk)
        begin
            if(~rst)
                PC <= {16{1'b0}};
            else
                PC <= PC_Next;
        end
endmodule