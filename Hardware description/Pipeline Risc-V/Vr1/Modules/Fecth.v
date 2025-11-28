`timescale 1ns / 1ps

module Fetch(
    // Datapath
    input  clk,
    input  Reset, WE_mem,
    input  [9:0] PCTargetE,
    input  [31:0] WD_mem,
    output [31:0] InstrF,
    output [9:0] PCPlus4F,
    output reg [9:0] PCF,
    
    // Control Unit
    input PCSrc,
    
    // Hazard Unit
    input StallF
    );
    
    wire [9:0] PCFNext;
    
    assign PCPlus4F = PCF + 10'b0000000100;
    assign PCFNext = PCSrc ? PCTargetE : PCPlus4F;
    
    //Registro contador
    always @(posedge clk or posedge Reset) begin
        if (Reset)
            PCF <= 0;
        else if (StallF)
            PCF <= PCF;
        else
            PCF <= PCFNext; 
    end
    
    
    Instruction_memory ins_mem(
        .clk(clk),
        .WE(WE_mem),
        .A(PCF),
        .WD(WD_mem),
        .RD(InstrF)
    );
    
endmodule