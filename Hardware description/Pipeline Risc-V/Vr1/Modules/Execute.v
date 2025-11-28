`timescale 1ns / 1ps

module Execute(
    // Datapath
    input [2:0] funct3E,
    input funct7_5E,
    input [31:0] RD1E, RD2E, ImmExtEin, forwardW, forwardM,
    input [4:0] RdEin, rs1Ein, rs2Ein,
    input [9:0] PCE, PCPlus4Ein, ImmExtEin10,
    output [31:0] ALUResultE, WriteData, ImmExtEout, 
    output [4:0] RdEout,
    output [9:0] PCPlus4Eout, PCTargetE,
    
    // Control Unit
    input ALUSrcE,
    input [2:0] ALUControlE,
    output Zero,
    
    // Hazard Unit
    input [1:0] Select_A, Select_B,
    output [4:0] rs1Eout, rs2Eout
    );
    
    reg [31:0] SrcAE, SrcB0;
    wire [31:0] SrcBE;
    
    always @(*) begin
        case (Select_A)
            2'b00: SrcAE = RD1E;
            2'b01: SrcAE = forwardW;
            2'b10: SrcAE = forwardM;
            default: SrcAE = 32'b0;
        endcase
    end
    
    always @(*) begin
        case (Select_B)
            2'b00: SrcB0 = RD2E;
            2'b01: SrcB0 = forwardW;
            2'b10: SrcB0 = forwardM;
            default: SrcB0 = 32'b0;
        endcase
    end
    
    assign SrcBE = ALUSrcE ? ImmExtEin : SrcB0;
    
    assign ImmExtEout = ImmExtEin;
    
    alu_top ALU (
        .A(SrcAE),
        .B(SrcBE),
        .funct3(funct3E),
        .funct7_5(funct7_5E),
        .ALUControl(ALUControlE),
        .Result(ALUResultE),
        .Zero(Zero)
    );
    
    assign WriteData = SrcB0;
    
    assign RdEout = RdEin;
    
    assign PCTargetE = PCE + ImmExtEin10;
    
    assign PCPlus4Eout = PCPlus4Ein;
    
    assign rs1Eout = rs1Ein;
    assign rs2Eout = rs2Ein;
    
endmodule
