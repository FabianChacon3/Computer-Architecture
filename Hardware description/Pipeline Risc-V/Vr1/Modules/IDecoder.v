`timescale 1ns / 1ps

module IDecoder(
    // Datapath
    input clk,
    input [31:0]  instr, Result,
    input [4:0]   RdW,
    input [9:0]   PCDin, PCPlus4Din,
    output [31:0] RD1D, RD2D, ImmExtD, 
    output [4:0]  RdD, rs1D, rs2D,
    output [9:0]  PCDout, PCPlus4Dout,
    
    // Control Unit
    input [1:0] ImmSrcD,
    input RegWriteW,
    output [6:0] op,
    output [2:0] funct3,
    output funct7_5,
    
    // Hazard Unit
    input Select_C, Select_D
    );
    
    // Control Unit
    assign op = instr[6:0];
    assign funct3 = instr[14:12];
    assign funct7_5 = instr[30];
    
    // MMC
    assign rs1D = instr[19:15];
    assign rs2D = instr[24:20];
    assign RdD = instr[11:7];
    
    wire [31:0] RD1_reg, RD2_reg;
    
    regfile RegFile(
        .clk(clk),
        .WE(RegWriteW),
        .A1(rs1D),
        .A2(rs2D),
        .A3(RdW),
        .WD3(Result),
        .RD1(RD1_reg),
        .RD2(RD2_reg)
    );
    
    wire [31:0] forwardW;
    assign forwardW = Result;   
    
    assign RD1D = Select_C ? forwardW : RD1_reg;
    assign RD2D = Select_D ? forwardW : RD2_reg;
    
    assign PCDout = ImmSrcD[0] ? PCDin : RD1_reg[9:0];
    
    ImmExt immext(
        .instr(instr[31:7]),
        .instr_4(instr[4]),
        .ImmSrc(ImmSrcD),
        .imm_ext(ImmExtD)
    );
    
    assign PCPlus4Dout = PCPlus4Din;
    
endmodule