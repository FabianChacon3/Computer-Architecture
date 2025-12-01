`timescale 1ns / 1ps
module tb_regfile;

    reg clk;
    reg WE;
    reg [4:0] A1, A2, A3;
    reg [31:0] WD3;
    wire [31:0] RD1, RD2;
    integer i; // ? Declaración del contador de bucle válida en Verilog-2001

    // Instancia del módulo
    regfile uut (
        .clk(clk),
        .WE(WE),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .WD3(WD3),
        .RD1(RD1),
        .RD2(RD2)
    );

    // Generador de reloj
    always #5 clk = ~clk;

    initial begin
        $display("\n======================================");
        $display("   TESTBENCH DEL REGISTER FILE RISC-V ");
        $display("======================================\n");

        clk = 0;
        WE  = 0;
        A1  = 0;
        A2  = 0;
        A3  = 0;
        WD3 = 0;
        #10;

        // ---------------------------------------------
        // 1. Escritura en varios registros
        // ---------------------------------------------
        WE = 1;
        A3 = 5'd5;  WD3 = 32'hAAAA_BBBB; #10;
        $display("Escrito r5  = %h", WD3);
        A3 = 5'd10; WD3 = 32'h1234_5678; #10;
        $display("Escrito r10 = %h", WD3);
        A3 = 5'd15; WD3 = 32'hDEAD_BEEF; #10;
        $display("Escrito r15 = %h", WD3);
        WE = 0;

        // ---------------------------------------------
        // 2. Lectura de registros escritos
        // ---------------------------------------------
        #10;
        A1 = 5'd5;  A2 = 5'd10; #1;
        $display("Lectura r5  -> RD1 = %h", RD1);
        $display("Lectura r10 -> RD2 = %h", RD2);

        #10;
        A1 = 5'd15; A2 = 5'd0; #1;
        $display("Lectura r15 -> RD1 = %h", RD1);
        $display("Lectura r0  -> RD2 = %h (debe ser 0)", RD2);

        // ---------------------------------------------
        // 3. Intento de escritura en r0
        // ---------------------------------------------
        WE = 1;
        A3 = 5'd0; WD3 = 32'hFFFF_FFFF; #10;
        WE = 0;
        A1 = 5'd0; #1;
        $display("Intento escribir r0 = FFFF_FFFF ? Lectura r0 = %h (debe seguir 0)", RD1);

        // ---------------------------------------------
        // 4. Sobrescritura y lectura cruzada
        // ---------------------------------------------
        WE = 1;
        A3 = 5'd5; WD3 = 32'hABCD_0001; #10;
        WE = 0;
        A1 = 5'd5; A2 = 5'd10; #1;
        $display("r5 actualizado = %h, r10 = %h", RD1, RD2);

        // ---------------------------------------------
        // 5. Prueba exhaustiva de escritura
        // ---------------------------------------------
        $display("\nEscribiendo todos los registros (excepto r0)...");
        WE = 1;
        for (i = 0; i < 32; i = i + 1) begin
            A3 = i[4:0];
            WD3 = i * 32'h1111_1111;
            #10;
        end
        WE = 0;

        // Lectura aleatoria (sin usar $urandom)
        $display("\nLectura aleatoria tras escritura masiva:");
        A1 = 5'd3;  A2 = 5'd7;  #10; $display("r3 = %h, r7 = %h", RD1, RD2);
        A1 = 5'd12; A2 = 5'd25; #10; $display("r12 = %h, r25 = %h", RD1, RD2);
        A1 = 5'd18; A2 = 5'd31; #10; $display("r18 = %h, r31 = %h", RD1, RD2);

        // ---------------------------------------------
        // Fin
        // ---------------------------------------------
        $display("\n======================================");
        $display("   FIN DEL TESTBENCH DEL REGFILE");
        $display("======================================\n");
        #20;
        $finish;
    end

endmodule

