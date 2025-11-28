`timescale 1ns / 1ps

module ReadMemory(
    // Datapath
    input clk,
    input [31:0] ALUResultMin, WriteData, ImmExtMin,
    input [4:0] RdMin,
    input [9:0] PCPlus4Min,
    output [31:0] ALUResultMout, ReadDataM, ImmExtMout,
    output [4:0] RdMout,
    output [9:0] PCPlus4Mout,
    
    // Control Unit
    input MemWriteM
    );
    
    assign ALUResultMout = ALUResultMin;
    
    Data_memory DataMem(
        .clk(clk),           
        .WE(MemWriteM),            
        .A(ALUResultMin[9:0]),  
        .WD(WriteData), 
        .RD(ReadDataM)
    );
    //module PeriphSystem(
    //    .clk(clk),
    //    .WE(MemWriteM),                    // Write Enable desde CPU
    //    .Address(ALUResultMin[10:0]),      // Dirección completa
    //    .WriteData(WriteData),             // Dato de escritura
    //    .ReadData(ReadDataM)               // Dato leído
    //);                                 
                                         
    assign RdMout = RdMin;               
    
    assign ImmExtMout = ImmExtMin;
    
    assign PCPlus4Mout = PCPlus4Min;
    
endmodule
