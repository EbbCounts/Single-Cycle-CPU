`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2024 03:04:16 PM
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory(
    input rst,
    input [15:0] PC,
    output [15:0] Instruction
    );

    reg [15:0] mem [0:1023];
    
    assign Instruction = (~rst) ? {16{1'b0}} : mem[PC[15:0]];
    
    //read in the mem file
    initial begin
        $readmemb("instrmem.mem", mem);
    end

endmodule
