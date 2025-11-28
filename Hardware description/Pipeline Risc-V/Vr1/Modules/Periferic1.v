`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.11.2025 14:42:42
// Design Name: 
// Module Name: Periferic1
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


module Periferic1(
    input clk,
    input WE,
    input [3:0] INPUTSP1,
    input [6:0] WriteData,
    output reg [3:0] ReadData,
    output reg [6:0] READINGP1
    );
    
    always @(posedge clk) begin
        if (WE)
            READINGP1 <= WriteData;
    end
    
    always @(*) begin
        ReadData <= INPUTSP1;
    end
    
endmodule
