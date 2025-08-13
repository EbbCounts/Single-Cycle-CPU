`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2024 03:04:31 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [15:0] A, B,
    input [1:0] ALUOp,
    output carry, overflow, zero, negative,
    output [15:0] result);
    
    wire Cout;
    wire [15:0] Sum;
    
    //add, sub, and, or
    //assign statement does addition and subtraction, ternary operator to seperare AND and OR
    assign {Cout, Sum} = (ALUOp[0] == 1'b0) ? A + B : (A + ((~B) + 1));
    assign result = (ALUOp == 2'b00 ) ? Sum :          //add
                    (ALUOp == 2'b01 ) ? Sum :          //sub
                    (ALUOp == 2'b10 ) ?  A & B :     //and
                    A | B ;     //or (final case is or)
    
    assign carry = ((~ALUOp[1]) & Cout);              
    assign overflow = ((Sum[15] ^ A[15]) & (~(ALUOp[0] ^ A[15] & B[15])) & (~ALUOp[1]));
    assign zero = &(~result);
    assign negative = result[15] ;
    
endmodule
