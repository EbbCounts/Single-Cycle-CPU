`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2024 03:04:31 PM
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit(
    input [3:0] opcode,
    output reg Branch, MemRead, MemWrite, MemtoReg, ALUSrc, RegWrite, Jump, ImmSrc, Halt,
    output reg [1:0] ALUOp 
    );
    
    always @(*) begin
        // Default control signals
        RegWrite = 0;
        ALUSrc   = 0;
        MemRead  = 0;
        MemWrite = 0;
        Branch   = 0;
        ALUOp   = 2'b00;
        Jump     = 0;
        Halt     = 0;

    
    case (opcode)
                4'b0001: begin // ADD
                    RegWrite <= 1;
                    ALUOp [1] <= 0;
                    ALUOp [0] <= 1;
                end
    
                4'b0010: begin // SUB
                    RegWrite <= 1;
                    ALUOp [1] <= 1;
                    ALUOp [0] <= 0;
                end
    
                4'b0011: begin // ADDI
                    RegWrite <= 1;
                    ALUSrc   <= 1;
                    ALUOp [1] <= 0;
                    ALUOp [0] <= 1;
                    ImmSrc <= 1;
                end
    
                4'b0100: begin // SUBI
                    RegWrite <= 1;
                    ALUSrc   <= 1;
                    ALUOp [1] <= 1;
                    ALUOp [0] <= 0;
                    ImmSrc <= 1;
                end
    
                4'b0101: begin // LSH
                    RegWrite <= 1;
                    ALUOp [1] <= 1;
                    ALUOp [0] <= 1;
                end
    
                4'b0110: begin // RSH
                    RegWrite <= 1;
                    ALUOp [1] <= 1;
                    ALUOp [0] <= 1;
                end
    
                4'b0111: begin // JUMP
                    Jump <= 1;
                end
    
                4'b1000: begin // JUMPL
                    Jump <= 1;
                end
    
                4'b1001: begin // BGE
                    Branch <= 1;
                    ALUOp [1] <= 0;
                    ALUOp [0] <= 1;
                end
    
                4'b1010: begin // BLE
                    Branch <= 1;
                    ALUOp [1] <= 1;
                    ALUOp [0] <= 0;
                end
    
                4'b1011: begin // BNE
                    Branch <= 1;
                    ALUOp [1] <= 1;
                    ALUOp [0] <= 0;
                end
    
                4'b1100: begin // LOAD
                    RegWrite <= 1;
                    MemRead  <= 1;
                    ALUSrc   <= 1;
                    ImmSrc <= 1;
                end
    
                4'b1101: begin // STORE
                    MemWrite <= 1;
                    ALUSrc   <= 1;
                    ImmSrc <= 1;
                end
    
                4'b1110: begin // AND
                    RegWrite <= 1;
                    ALUOp [1] <= 0;
                    ALUOp [0] <= 0;
                end
    
                4'b1111: begin // OR
                    RegWrite <= 1;
                    ALUOp [1] <= 0;
                    ALUOp [0] <= 1;
                end
    
                4'b0000: begin // HALT
                    Halt <= 1;
                end
    
                default: begin
                    // All signals are 0 by default
                end
            endcase
        end

endmodule
