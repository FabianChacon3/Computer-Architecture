`timescale 1ns / 1ps
module regfile (
    input  wire        clk,
    input  wire        WE,          // Write Enable
    input  wire [4:0]  A1, A2, A3,   // direcciones de lectura/escritura (0–31)
    input  wire [31:0] WD3,          // dato de escritura
    output reg  [31:0] RD1, RD2      // datos de lectura
);

    // 31 registros (r1–r31). r0 no existe físicamente
    reg [31:0] r1,  r2,  r3,  r4,  r5,  r6,  r7;
    reg [31:0] r8,  r9,  r10, r11, r12, r13, r14, r15;
    reg [31:0] r16, r17, r18, r19, r20, r21, r22, r23;
    reg [31:0] r24, r25, r26, r27, r28, r29, r30, r31;

    // Escritura síncrona: no se escribe en A3=0
    always @(posedge clk) begin
        if (WE) begin
            case (A3)
                5'd1 :  r1  <= WD3;
                5'd2 :  r2  <= WD3;
                5'd3 :  r3  <= WD3;
                5'd4 :  r4  <= WD3;
                5'd5 :  r5  <= WD3;
                5'd6 :  r6  <= WD3;
                5'd7 :  r7  <= WD3;
                5'd8 :  r8  <= WD3;
                5'd9 :  r9  <= WD3;
                5'd10:  r10 <= WD3;
                5'd11:  r11 <= WD3;
                5'd12:  r12 <= WD3;
                5'd13:  r13 <= WD3;
                5'd14:  r14 <= WD3;
                5'd15:  r15 <= WD3;
                5'd16:  r16 <= WD3;
                5'd17:  r17 <= WD3;
                5'd18:  r18 <= WD3;
                5'd19:  r19 <= WD3;
                5'd20:  r20 <= WD3;
                5'd21:  r21 <= WD3;
                5'd22:  r22 <= WD3;
                5'd23:  r23 <= WD3;
                5'd24:  r24 <= WD3;
                5'd25:  r25 <= WD3;
                5'd26:  r26 <= WD3;
                5'd27:  r27 <= WD3;
                5'd28:  r28 <= WD3;
                5'd29:  r29 <= WD3;
                5'd30:  r30 <= WD3;
                5'd31:  r31 <= WD3;
                default: ; // A3=0 no hace nada
            endcase
        end
    end

    // Lectura combinacional puerto 1
    always @(*) begin
        case (A1)
            5'd0 :  RD1 = 32'b0;      // reg0 fijo en cero
            5'd1 :  RD1 = r1;
            5'd2 :  RD1 = r2;
            5'd3 :  RD1 = r3;
            5'd4 :  RD1 = r4;
            5'd5 :  RD1 = r5;
            5'd6 :  RD1 = r6;
            5'd7 :  RD1 = r7;
            5'd8 :  RD1 = r8;
            5'd9 :  RD1 = r9;
            5'd10:  RD1 = r10;
            5'd11:  RD1 = r11;
            5'd12:  RD1 = r12;
            5'd13:  RD1 = r13;
            5'd14:  RD1 = r14;
            5'd15:  RD1 = r15;
            5'd16:  RD1 = r16;
            5'd17:  RD1 = r17;
            5'd18:  RD1 = r18;
            5'd19:  RD1 = r19;
            5'd20:  RD1 = r20;
            5'd21:  RD1 = r21;
            5'd22:  RD1 = r22;
            5'd23:  RD1 = r23;
            5'd24:  RD1 = r24;
            5'd25:  RD1 = r25;
            5'd26:  RD1 = r26;
            5'd27:  RD1 = r27;
            5'd28:  RD1 = r28;
            5'd29:  RD1 = r29;
            5'd30:  RD1 = r30;
            5'd31:  RD1 = r31;
            default: RD1 = 32'b0;
        endcase
    end

    // Lectura combinacional puerto 2
    always @(*) begin
        case (A2)
            5'd0 :  RD2 = 32'b0;      // reg0 fijo en cero
            5'd1 :  RD2 = r1;
            5'd2 :  RD2 = r2;
            5'd3 :  RD2 = r3;
            5'd4 :  RD2 = r4;
            5'd5 :  RD2 = r5;
            5'd6 :  RD2 = r6;
            5'd7 :  RD2 = r7;
            5'd8 :  RD2 = r8;
            5'd9 :  RD2 = r9;
            5'd10:  RD2 = r10;
            5'd11:  RD2 = r11;
            5'd12:  RD2 = r12;
            5'd13:  RD2 = r13;
            5'd14:  RD2 = r14;
            5'd15:  RD2 = r15;
            5'd16:  RD2 = r16;
            5'd17:  RD2 = r17;
            5'd18:  RD2 = r18;
            5'd19:  RD2 = r19;
            5'd20:  RD2 = r20;
            5'd21:  RD2 = r21;
            5'd22:  RD2 = r22;
            5'd23:  RD2 = r23;
            5'd24:  RD2 = r24;
            5'd25:  RD2 = r25;
            5'd26:  RD2 = r26;
            5'd27:  RD2 = r27;
            5'd28:  RD2 = r28;
            5'd29:  RD2 = r29;
            5'd30:  RD2 = r30;
            5'd31:  RD2 = r31;
            default: RD2 = 32'b0;
        endcase
    end

endmodule