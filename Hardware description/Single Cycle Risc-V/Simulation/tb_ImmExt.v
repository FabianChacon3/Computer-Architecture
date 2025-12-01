`timescale 1ns / 1ps
module tb_ImmExt;

    reg [31:0] instr_full;
    reg [31:7] instr;
    reg        instr_4;
    reg [1:0]  ImmSrc;
    wire [31:0] imm_ext;

    // Instancia del módulo bajo prueba
    ImmExt uut (
        .instr(instr),
        .ImmSrc(ImmSrc),
        .instr_4(instr_4),
        .imm_ext(imm_ext)
    );

    initial begin
        $display("=== Simulación ImmExt ===\n");

        // ============================================================
        // I-type (ADDI) - el único tipo que puede tener instr_4=1 ? U
        // ============================================================

        // Caso 1: ADDI con signo negativo
        instr_full = 32'b1_00000000111_00010_000_00001_0010011;
        instr      = instr_full[31:7];
        instr_4    = instr_full[4];  // bit 4
        ImmSrc     = 2'b00;
        #10 $display("ADDI 1 | instr[31:7]=%b | instr[4]=%b | imm_field=%b | imm_ext=%h (signed=%0d)",
                     instr, instr_4, instr_full[31:20], imm_ext, $signed(imm_ext));

        // Caso 2: ADDI positivo
        instr_full = 32'b0_00000000100_00100_000_00101_0010011;
        instr      = instr_full[31:7];
        instr_4    = instr_full[4];
        ImmSrc     = 2'b00;
        #10 $display("ADDI 2 | instr[31:7]=%b | instr[4]=%b | imm_field=%b | imm_ext=%h (signed=%0d)",
                     instr, instr_4, instr_full[31:20], imm_ext, $signed(imm_ext));

        // ============================================================
        // S-type - instr_4 no aplica, siempre 0
        // ============================================================

        instr_full = 32'b1_0000000_00011_00010_000_00001_0100011;
        instr      = instr_full[31:7];
        instr_4    = 1'b0;
        ImmSrc     = 2'b01;
        #10 $display("S-type 1 | instr[31:7]=%b | instr[4]=%b | imm_field={31:25,11:7}=%b | imm_ext=%h (signed=%0d)",
                     instr, instr_4, {instr_full[31:25], instr_full[11:7]}, imm_ext, $signed(imm_ext));

        instr_full = 32'b0_0000011_00100_00101_000_01000_0100011;
        instr      = instr_full[31:7];
        instr_4    = 1'b0;
        ImmSrc     = 2'b01;
        #10 $display("S-type 2 | instr[31:7]=%b | instr[4]=%b | imm_field={31:25,11:7}=%b | imm_ext=%h (signed=%0d)",
                     instr, instr_4, {instr_full[31:25], instr_full[11:7]}, imm_ext, $signed(imm_ext));

        // ============================================================
        // U-type - instr_4 = 1 siempre
        // ============================================================

        instr_full = 32'b00000000000000000001000000110111;
        instr      = instr_full[31:7];
        instr_4    = 1'b1;
        ImmSrc     = 2'b01;  // tu diseño puede usar mismo código que S-type
        #10 $display("U-type 1 | instr[31:7]=%b | instr[4]=%b | imm_field(31:12)=%b | imm_ext=%h",
                     instr, instr_4, instr_full[31:12], imm_ext);

        instr_full = 32'b00000000000100000010000000110111;
        instr      = instr_full[31:7];
        instr_4    = 1'b1;
        ImmSrc     = 2'b01;
        #10 $display("U-type 2 | instr[31:7]=%b | instr[4]=%b | imm_field(31:12)=%b | imm_ext=%h",
                     instr, instr_4, instr_full[31:12], imm_ext);
        
       // ============================================================
       // B-type (Branches)
       // ============================================================
       
       instr_full = 32'b11111100001100010000000001100011; // BEQ x2, x3, -16
       instr      = instr_full[31:7];
       instr_4    = instr_full[4];
       ImmSrc     = 2'b10;
       #10 $display("B-type (BEQ) | instr[31:7]=%b | instr[4]=%b | imm_field={31,7,30:25,11:8,0}=... | imm_ext=%h (signed=%0d)",
                    instr, instr_4, imm_ext, $signed(imm_ext));
       
       instr_full = 32'b00000110000100101001011001100011; // BNE x5, x1, +24
       instr      = instr_full[31:7];
       instr_4    = instr_full[4];
       ImmSrc     = 2'b10;
       #10 $display("B-type (BNE) | instr[31:7]=%b | instr[4]=%b | imm_ext=%h (signed=%0d)",
                    instr, instr_4, imm_ext, $signed(imm_ext));
       
       
       // ============================================================
       // J-type (Jumps)
       // ============================================================
       
       instr_full = 32'b00000001000000000000000011101111; // JAL x1, +2048
       instr      = instr_full[31:7];
       instr_4    = instr_full[4];
       ImmSrc     = 2'b11;
       #10 $display("J-type (JAL +2048) | instr[31:7]=%b | instr[4]=%b | imm_ext=%h (signed=%0d)",
                    instr, instr_4, imm_ext, $signed(imm_ext));
       
       instr_full = 32'b11111110000000000000000011101111; // JAL x1, -4096
       instr      = instr_full[31:7];
       instr_4    = instr_full[4];
       ImmSrc     = 2'b11;
       #10 $display("J-type (JAL -4096) | instr[31:7]=%b | instr[4]=%b | imm_ext=%h (signed=%0d)",
                    instr, instr_4, imm_ext, $signed(imm_ext));
       
        $display("\n=== Fin de simulación ===");
        #10 $finish;
    end

endmodule



