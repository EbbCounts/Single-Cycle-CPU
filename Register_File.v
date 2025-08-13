`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2024 03:04:54 PM
// Design Name: 
// Module Name: Register_File
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


module Register_File(
    //RegWrite is an enable signal, WriteData is from the Multiplexer after the Data Memory block
    input clk, rst, RegWrite, 
    input [3:0] rs, rt, rd, inr, //read registers rs, rt, but write to register rd
    input [15:0] WriteData,
    output reg [15:0] ReadData1, ReadData2, outValue 
    //ReadData1 and ReadData2 contain the data we are writing to (aka the data we are sending along the datapath)
    );
    
    reg [15:0] Register [15:0];
    
    initial begin
        Register[0] = 16'b0; //register 0 is always 0
        Register[4] = 16'b0; //register 4 is the PC register
    end
    
    // Read 
        always @(*) begin
            ReadData1 = Register[rs];
            ReadData2 = Register[rt];
            outValue = Register[inr];
        end
    

    //Write 
    always @(posedge clk or posedge rst) begin
            if (~rst) begin
                // Set all registers to 0 when reset is active
                            Register[0] <= 16'b0; //Zero 
                            Register[1] <= 16'b0; //Return reg
                            Register[2] <= 16'b0; //Stack Pointer
                            Register[3] <= 16'b0; //Link Register
                            Register[4] <= 16'b0; //Program Counter
                            Register[5] <= 16'b0; //Temp
                            Register[6] <= 16'b0; //Temp
                            Register[7] <= 16'b0; //Temp     
                            Register[8] <= 16'b0; //Temp
                            Register[9] <= 16'b0; //Function Arguments
                            Register[10] <= 16'b0; //Function Arguments
                            Register[11] <= 16'b0; //Function Arguments
                            Register[12] <= 16'b0; //Function Arguments
                            Register[13] <= 16'b0; //Saved
                            Register[14] <= 16'b0; //Saved
                            Register[15] <= 16'b0; //Saved     
            //end else if (RegWrite && writeReg != 0) begin // Do not allow writing to zero register R0
            end else if (RegWrite && rd != 0) begin // Do not allow writing to zero register R0
                Register[rd] <= WriteData; //we are only going to write to rd, we dont write to rs or rt
            end
        end
    
endmodule
