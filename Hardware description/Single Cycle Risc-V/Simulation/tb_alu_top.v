`timescale 1ns / 1ps

module tb_alu_top();

    reg [31:0] A, B;
    reg [2:0] funct3;
    reg funct7_5;
    reg [2:0] ALUControl;
    wire [31:0] Result;

    alu_top uut (
        .A(A),
        .B(B),
        .funct3(funct3),
        .funct7_5(funct7_5),
        .ALUControl(ALUControl),
        .Result(Result)
    );

    initial begin
        $display("==== TEST INICIO ====");

        // ---- SUMA ----
        A = 32'd15; B = 32'd10;
        ALUControl = 3'b000; funct3 = 3'b000; funct7_5 = 0;
        #10;
        $display("ADD: A=%d B=%d => Result=%d", A, B, Result);

        // ---- RESTA ----
        A = 32'ha; B = 32'd7;
        ALUControl = 3'b001; funct3 = 3'b000; funct7_5 = 0;
        #10;
        $display("SUB: A=%d B=%d => Result=%d", A, B, Result);

        // ---- AND ----
        A = 32'hF0F0F0F0; B = 32'h0F0F0F0F;
        ALUControl = 3'b010; funct3 = 3'b000; funct7_5 = 0;
        #10;
        $display("AND: A=%h B=%h => Result=%h", A, B, Result);

        // ---- OR ----
        A = 32'hAAAA5555; B = 32'h0F0F0F0F;
        ALUControl = 3'b011; funct3 = 3'b000; funct7_5 = 0;
        #10;
        $display("OR:  A=%h B=%h => Result=%h", A, B, Result);

        // ---- XOR ----
        A = 32'hFF00FF00; B = 32'h0F0F0F0F;
        ALUControl = 3'b100; funct3 = 3'b000; funct7_5 = 0;
        #10;
        $display("XOR: A=%h B=%h => Result=%h", A, B, Result);

        // ---- SLT A < B ----
        A = 32'd5; B = 32'd10;
        ALUControl = 3'b101; funct3 = 3'b100; funct7_5 = 0;
        #10;
        $display("SLT (A < B): A=%d B=%d => Result=%d", A, B, Result);

        // ---- SLT A >= B ----
        A = 32'd12; B = 32'd6;
        ALUControl = 3'b101; funct3 = 3'b101; funct7_5 = 0;
        #10;
        $display("SLT (A >= B): A=%d B=%d => Result=%d", A, B, Result);

        // ---- SLT A == B ----
        A = 32'd15; B = 32'd15;
        ALUControl = 3'b101; funct3 = 3'b000; funct7_5 = 0;
        #10;
        $display("SLT (A == B): A=%d B=%d => Result=%d", A, B, Result);

        // ---- SLT A != B ----
        A = 32'd8; B = 32'd10;
        ALUControl = 3'b101; funct3 = 3'b001; funct7_5 = 0;
        #10;
        $display("SLT (A != B): A=%d B=%d => Result=%d", A, B, Result);

        // ---- SHIFT IZQUIERDA LÓGICO ----
        A = 32'h0000000F; B = 32'd2;
        ALUControl = 3'b110; funct3 = 3'b000; funct7_5 = 0;
        #10;
        $display("SLL: A=%h << %d => Result=%h", A, B[4:0], Result);

        // ---- SHIFT DERECHA LÓGICO ----
        A = 32'hF0000000; B = 32'd4;
        ALUControl = 3'b110; funct3 = 3'b100; funct7_5 = 0;
        #10;
        $display("SRL: A=%h >> %d => Result=%h", A, B[4:0], Result);

        // ---- SHIFT DERECHA ARITMÉTICO ----
        A = 32'hF0000000; B = 32'd4;
        ALUControl = 3'b110; funct3 = 3'b100; funct7_5 = 1;
        #10;
        $display("SRA: A=%h >>> %d => Result=%h", A, B[4:0], Result);

        $display("==== FIN TEST ====");
        $finish;
    end

endmodule