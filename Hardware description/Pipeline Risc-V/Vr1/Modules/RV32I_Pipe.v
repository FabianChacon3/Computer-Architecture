`timescale 1ns / 1ps

module RV32I_Pipe(
    input clk,
    input WE_mem,
    input [31:0] WD_mem,
    input Reset,
    input [3:0] INPUTSP1,
    output [6:0] READINGP1
    );
    
////// FETCH //////
    
    wire PCSrc;
    wire [9:0] PCTargetE;
    wire [31:0] InstrF;
    wire [9:0]  PCPlus4F;
    wire [9:0]  PCF;
    wire StallF;
    
    Fetch fetch_stage_inst (
        // Datapath
        .clk        (clk),
        .Reset      (Reset),
        .WE_mem     (WE_mem),
        .PCTargetE  (PCTargetE),
        .WD_mem     (WD_mem),
        .InstrF     (InstrF),
        .PCPlus4F   (PCPlus4F),
        .PCF        (PCF),
    
        // Control Unit
        .PCSrc      (PCSrc),
    
        // Hazard Unit
        .StallF     (StallF)
    );
    
    reg [31:0] InstrD;
    reg [9:0] PCD, PCPlus4Din;
    wire FlushD, StallD;
    
    always @(posedge clk) begin
        if (FlushD) begin
            InstrD <= 0;
            PCD <= 0;
            PCPlus4Din <= 0;
        end
        else if (StallD) begin
            InstrD <= InstrD;
            PCD <= PCD;
            PCPlus4Din <= PCPlus4Din;
        end
        else begin  
            InstrD <= InstrF;
            PCD <= PCF;
            PCPlus4Din <= PCPlus4F;
        end
    end
    
////// INSTRUCTION DECODER //////    

    // Control Unit
    
    wire RegWriteD;
    wire [1:0] ResultSrcD;
    wire MemWriteD;
    wire JumpD;
    wire BranchD;  
    wire [2:0] ALUControlD;
    wire ALUSrcD;
    wire [1:0] ImmSrcD;
    wire [6:0] op;
    wire [2:0] funct3;
    wire funct7_5;

    Control_Unit control_unit_inst (
        .op         (op),          // opcode desde la etapa D
        .funct3     (funct3),      // funct3 desde la etapa D
        .funct7     (funct7_5),      // bit 30 desde la etapa D
    
        .RegWrite   (RegWriteD),
        .ResultSrc  (ResultSrcD),
        .MemWrite   (MemWriteD),
        .Jump       (JumpD),
        .Branch     (BranchD),
        .ALUControl (ALUControlD),
        .ALUSrc     (ALUSrcD),
        .ImmSrc     (ImmSrcD)
    );
    
    // Datapath
    
    wire [31:0] RD1D, RD2D, ImmExtD;
    wire [4:0] rs1D, rs2D, RdD;
    wire [4:0] RdW;
    wire [9:0] PCPlus4D, PCDout;
    wire Select_C, Select_D;
    reg RegWriteW;
    wire [31:0] Result;
    
    IDecoder idecoder_inst (
        // Datapath
        .clk          (clk),
        .instr        (InstrD),
        .Result       (Result),      
        .RdW          (RdW),
        .PCDin        (PCD),
        .PCPlus4Din   (PCPlus4Din),
        .RD1D         (RD1D),
        .RD2D         (RD2D),
        .ImmExtD      (ImmExtD),
        .RdD          (RdD),
        .rs1D         (rs1D),
        .rs2D         (rs2D),
        .PCDout       (PCDout),
        .PCPlus4Dout  (PCPlus4D),
    
        // Control Unit
        .ImmSrcD      (ImmSrcD),
        .RegWriteW    (RegWriteW),
        .op           (op),
        .funct3       (funct3),
        .funct7_5     (funct7_5),
    
        // Hazard Unit
        .Select_C     (Select_C),
        .Select_D     (Select_D)
    );
    
    wire FlushE;

    reg RegWriteE, MemWriteE, JumpE, BranchE, ALUSrcE;
    reg [1:0] ResultSrcE;
    reg [2:0] funct3E;
    reg funct7_5E;
    reg [31:0] RD1E, RD2E, ImmExtE;
    reg [4:0] RdE, rs1E, rs2E;
    reg [9:0] PCE, PCPlus4E;
    reg [2:0] ALUControlE;

    
    always @(posedge clk) begin
        if (FlushE) begin
            // Control signals a cero (NOP)
            RegWriteE   <= 0;
            MemWriteE   <= 0;
            JumpE       <= 0;
            BranchE     <= 0;
            ALUSrcE     <= 0;
            ResultSrcE  <= 0;
            ALUControlE <= 0;
    
            // Campos de instrucción y registros también a cero
            funct3E     <= 0;
            funct7_5E   <= 0;
            RdE         <= 0;
            rs1E        <= 0;
            rs2E        <= 0;
    
            // Valores del datapath limpiados
            RD1E        <= 0;
            RD2E        <= 0;
            ImmExtE     <= 0;
    
            // PC también se limpia
            PCE         <= 0;
            PCPlus4E    <= 0;
        end 
        else begin
            // Aquí ponés los valores normales que vengan del registro D→E
            RegWriteE   <= RegWriteD;
            MemWriteE   <= MemWriteD;
            JumpE       <= JumpD;
            BranchE     <= BranchD;
            ALUSrcE     <= ALUSrcD;
            ResultSrcE  <= ResultSrcD;
            ALUControlE <= ALUControlD;
    
            funct3E     <= funct3;
            funct7_5E   <= funct7_5;
            RdE         <= RdD;
            rs1E        <= rs1D;
            rs2E        <= rs2D;
    
            RD1E        <= RD1D;
            RD2E        <= RD2D;
            ImmExtE     <= ImmExtD;
    
            PCE         <= PCDout;
            PCPlus4E    <= PCPlus4D;
        end
    end
    
////// EXECUTE ////// 

    
    wire [31:0] forwardM;
    
    wire [31:0] ALUResultE, ImmExtEout;
    wire [31:0] WriteDataE;
    wire [9:0]  PCPlus4Eout;
    wire Zero;
    wire [4:0] RdEout, rs1Eout, rs2Eout;
    wire [1:0] Select_A, Select_B;
    
    Execute execute_stage_inst (
        // Datapath
        .funct3E      (funct3E),
        .funct7_5E    (funct7_5E),
        .RD1E         (RD1E),
        .RD2E         (RD2E),
        .ImmExtEin    (ImmExtE),
        .forwardW     (Result),
        .forwardM     (forwardM),
        .RdEin        (RdE),
        .rs1Ein       (rs1E),
        .rs2Ein       (rs2E),
        .PCE          (PCE),
        .PCPlus4Ein   (PCPlus4E),
        .ImmExtEin10  (ImmExtE[9:0]),
        .ALUResultE   (ALUResultE),
        .WriteData    (WriteDataE),
        .ImmExtEout   (ImmExtEout),
        .RdEout       (RdEout),
        .PCPlus4Eout  (PCPlus4Eout),
        .PCTargetE    (PCTargetE),
    
        // Control Unit
        .ALUSrcE      (ALUSrcE),
        .ALUControlE  (ALUControlE),
        .Zero         (Zero),
    
        // Hazard Unit
        .Select_A     (Select_A),
        .Select_B     (Select_B),
        .rs1Eout      (rs1Eout),
        .rs2Eout      (rs2Eout)
    );
    
    assign PCSrc = JumpE | BranchE & Zero;
    
    reg RegWriteM, MemWriteM;
    reg [1:0] ResultSrcM;
    reg [31:0] ALUResultM, WriteDataM, ImmExtM;
    
    reg [4:0] RdM;
    reg [9:0] PCPlus4M;
    
    assign forwardM = ALUResultM;
    
    always @(posedge clk) begin
        RegWriteM <= RegWriteE;
        ResultSrcM <= ResultSrcE;
        MemWriteM <= MemWriteE;
        ALUResultM <= ALUResultE;
        WriteDataM <= WriteDataE;
        RdM <= RdEout;
        ImmExtM <= ImmExtEout;
        PCPlus4M <= PCPlus4Eout;
    end
    
 ////// MEMORY //////   

    wire [31:0] ReadDataM;
    
    PeriphSystem perifericos(
        .clk(clk),
        .WE(MemWriteM),                    // Write Enable desde CPU
        .INPUTSP1(INPUTSP1),
        .Address(ALUResultM[10:0]),      // Dirección completa
        .WriteData(WriteDataM),             // Dato de escritura
        .ReadData(ReadDataM),               // Dato leído
        .READINGP1(READINGP1)
    );                                 
    
    reg [1:0] ResultSrcW;
    reg [31:0] ALUResultW, ReadDataW, ImmExtW;
    reg [9:0] PCPlus4W;
    reg [4:0] RdWin;
    
    always @(posedge clk) begin
        RegWriteW <= RegWriteM;
        ResultSrcW <= ResultSrcM;
        ALUResultW <= ALUResultM;
        ImmExtW <= ImmExtM;
        ReadDataW <= ReadDataM;
        RdWin <= RdM;
        PCPlus4W <= PCPlus4M;
    end 
    
    
////// WRITE BACK //////
    
    
    
    WriteBack writeback_stage_inst (
        // Datapath
        .ALUResultW (ALUResultW),
        .ReadDataW  (ReadDataW),
        .ImmExtW    (ImmExtW),
        .PCPlus4W   (PCPlus4W),
        .RdWin      (RdWin),
    
        .Result     (Result),
        .RdWout     (RdW),
    
        // Control Unit
        .ResultSrcW (ResultSrcW)
    );
    
    
////// HAZARD UNIT //////

    Hazard_Unit hazard_unit_inst (
        // Entradas: desde Decode (D)
        .rs1_D       (rs1D),
        .rs2_D       (rs2D),
    
        // Entradas: desde Execute (E)
        .rs1_E       (rs1Eout),
        .rs2_E       (rs2Eout),
        .rd_E        (RdEout),
        .ResultSrcE  (ResultSrcE),
        .PCSrcE      (PCSrc),
    
        // Entradas: desde Memory (M)
        .rd_M        (RdM),
        .RegWrite_M  (RegWriteM),
    
        // Entradas: desde WriteBack (W)
        .rd_W        (RdW),
        .RegWrite_W  (RegWriteW),
    
        // Salidas hacia FETCH y DECODE
        .Stall_F     (StallF),
        .Stall_D     (StallD),
        .Flush_D     (FlushD),
        .Flush_E     (FlushE),
    
        // Forwarding hacia Execute
        .Select_A    (Select_A),
        .Select_B    (Select_B),
    
        // Control de bypass hacia Decode
        .Select_C    (Select_C),
        .Select_D    (Select_D)
    );

    
endmodule
