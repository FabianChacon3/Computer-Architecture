`timescale 1ns / 1ps

module Hazard_Unit(
    input  [4:0] rs1_D, rs2_D,
    input  [4:0] rs1_E, rs2_E,
    input  [4:0] rd_E, rd_M, rd_W,
    input        RegWrite_M, RegWrite_W,
    input  [1:0] ResultSrcE,
    input        PCSrcE,

    output reg   Stall_F, Stall_D, Flush_E,
    output reg   Flush_D,
    output reg [1:0] Select_A, Select_B,
    output reg   Select_C, Select_D
);

    // ================================
    // Load-Use Hazard (Stall / Flush)
    // ================================
    always @(*) begin
        if ( ((rs1_D == rd_E) || (rs2_D == rd_E)) &&
             (ResultSrcE == 2'b01) &&
             (rd_E != 5'd0) ) begin
            Stall_F = 1;
            Stall_D = 1;
            Flush_E = 1;
        end else begin
            Stall_F = 0;
            Stall_D = 0;
            Flush_E = 0;
        end
    end

    // ================================
    // Forwarding a la ALU (Select_A)
    // ================================
    always @(*) begin
        case (1'b1)
            (rs1_E == rd_M && RegWrite_M && rd_M != 0): Select_A = 2'b10;
            (rs1_E == rd_W && RegWrite_W && rd_W != 0): Select_A = 2'b01;
            default:                                    Select_A = 2'b00;
        endcase
    end

    // ================================
    // Forwarding a la ALU (Select_B)
    // ================================
    always @(*) begin
        case (1'b1)
            (rs2_E == rd_M && RegWrite_M && rd_M != 0): Select_B = 2'b10;
            (rs2_E == rd_W && RegWrite_W && rd_W != 0): Select_B = 2'b01;
            default:                                    Select_B = 2'b00;
        endcase
    end

    // ================================
    // Forwarding temprano a ID (Select_C)
    // ================================
    always @(*) begin
        Select_C = (rs1_D == rd_W && RegWrite_W && rd_W != 0) ? 1'b1 : 1'b0;
    end

    // ================================
    // Forwarding temprano a ID (Select_D)
    // ================================
    always @(*) begin
        Select_D = (rs2_D == rd_W && RegWrite_W && rd_W != 0) ? 1'b1 : 1'b0;
    end

    // ================================
    // Control Hazard (Flush_D)
    // ================================
    always @(*) begin
        Flush_D = PCSrcE;
    end

endmodule
