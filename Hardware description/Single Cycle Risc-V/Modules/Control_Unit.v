`timescale 1ns / 1ps
module Control_Unit(
    input  [6:0] op,         // Opcode
    input  [2:0] funct3,     // Campo funct3
    input        funct7,     // Bit 30 (funct7[5])
    input        Zero,       // Bandera de cero de la ALU

    output       RegWrite,
    output [1:0] ImmSrc,
    output       ALUSrc,
    output       MemWrite,
    output [1:0] ResultSrc,
    output       PCSrc,      // Señal para seleccionar PC siguiente
    output [2:0] ALUControl  // Señal de control hacia la ALU
);

    // Señal interna entre los decoders
    wire [1:0] ALUOp;
    wire       Branch;

    // =============================
    // Instancia del MAIN DECODER
    // =============================
    Main_decoder main_dec (
        .op(op),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );

    // =============================
    // Instancia del ALU DECODER
    // =============================
    ALU_decoder alu_dec (
        .funct3(funct3),
        .funct7(funct7),
        .ALUOp(ALUOp),
        .ALUControl(ALUControl)
    );

    // =============================
    // Lógica de PCSrc
    // =============================
    assign PCSrc = Branch & Zero;

endmodule
