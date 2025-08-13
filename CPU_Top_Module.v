`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2024 05:37:21 PM
// Design Name: 
// Module Name: CPU_Top_Module
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
//`include "ALU.v"
//`include "Adder.v"
//`include "Control_Unit.v"
//`include "Data_Memory.v"
//`include "Instruction_Memory.v"
//`include "Mux.v"
//`include "PC.v"
//`include "Register_File.v"
//`include "Sign_Extension.v"

module CPU_Top_Module(
    input clk, rst,
    input [3:0] inr,
    output [15:0] outValue
    );
    
    // component connection wires
    wire [15:0] pc_out, pc_next, pc_plus_4, instruction;
    wire [4:0] rs, rt, rd;
    wire [15:0] read_data1, read_data2, alu_result, mem_data, write_data;
    wire [15:0] imm_extended, alu_operand2, branch_addr;
    wire Zero, Carry, Overflow, Negative; //ALU flags

    // Control signals
    wire RegWrite, ALUSrc, MemRead, MemWrite, Branch, Jump, Halt, ImmSrc, MemtoReg;
    wire [1:0] ALUOp;
    wire [3:0] opcode = instruction[15:12];  

    // Program Counter (PC)
    PC PC (
        .clk(clk),
        .rst(rst),
        .PC_Next(pc_next),
        .PC(pc_out)
    );

    // Instruction Memory
    Instruction_Memory Instruction_Memory (
        .rst(rst),
        .PC(pc_out),
        .Instruction(instruction)
    );

    // Control Unit
    Control_Unit Control_Unit (
        .opcode(opcode),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp(ALUOp),
        .Jump(Jump),
        .Halt(Halt),
        .ImmSrc(ImmSrc)
    );

    // Register file
    Register_File Register_File (
        .clk(clk),
        .rst(rst),
        .RegWrite(RegWrite),
        .rs(instruction[11:8]),  
        .rt(instruction[7:4]), 
        .rd(instruction[3:0]),  
        .inr(inr),
        .WriteData(write_data),
        .ReadData1(read_data1),
        .ReadData2(read_data2),
        .outValue(outValue)
    );

    // Sign Extension
    Sign_Extension sign_ext (
        .Immediate(instruction[3:0]), 
        .ImmediateSourceControl(ImmSrc),
        .Immediate_Extension(imm_extended)
    );

    // MUX for ALU source operand
    Mux #(16) alu_operand_mux (
        .a(read_data2), 
        .b(imm_extended),
        .sel(ALUSrc),
        .c(alu_operand2)
    );

    // ALU
    ALU ALU (
        .A(read_data1),
        .B(alu_operand2),
        .ALUOp(ALUOp),
        .result(alu_result),
        .zero(Zero),
        .carry(Carry),
        .overflow(Overflow),
        .negative(Negative)
    );

    // Data Memory
    Data_Memory Data_Memory (
        .clk(clk),
        .rst(rst),
        .MemWrite(MemWrite),
        .WriteData(read_data2),
        .ALUResult(alu_result),
        .ReadData(mem_data)
    );

    // MUX for selecting write-back data to the register file
    Mux #(16) wb_mux (
        .a(mem_data),
        .b(alu_result),
        .sel(MemtoReg),
        .c(write_data)
    );

    // PC increment by 4
    Adder pc_adder (
        .a(pc_out),
        .b(16'd4),
        .c(pc_plus_4)
    );

    // Branch address calculation
    Adder branch_adder (
        .a(pc_plus_4),
        .b(imm_extended << 2),  // Shift left 2 for word alignment
        .c(branch_addr)
    );

    // MUX for PC selection
    Mux #(16) pc_mux (
        .a(pc_plus_4),         // Next sequential instruction
        .b(branch_addr),       // Branch address
        .sel((Branch & Zero) | (Jump & Zero)),   // Branch only if condition is met
        .c(pc_next)
    );

    
endmodule
