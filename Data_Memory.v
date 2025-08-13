`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2024 03:02:14 PM
// Design Name: 
// Module Name: Data_Memory
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

module Data_Memory(
    input clk, rst, MemWrite, 
    input [15:0] ALUResult, WriteData,
    output reg [15:0] ReadData
);
    // Intermediate wire to hold raw data from memory
    wire [15:0] mem_out;
    
    // Signal to control the enable pin of the block memory
    wire ena;
    
    // Instantiate the block memory
    blk_mem_gen_0 memory_inst (
        .clka(clk),                  // Clock input
        .wea(MemWrite),              // Write enable
        .addra(ALUResult),           // Address input
        .dina(WriteData),            // Data input
        .douta(mem_out),              // Data output
        .ena(ena)                    // Enable input
    );

    assign ena = (rst);  

    // ReadData with reset behavior
    always @(posedge clk) begin
        if (~rst)
            ReadData <= 16'b0;  // Reset value
        else
            ReadData <= mem_out;  // Pass BRAM output
    end
endmodule