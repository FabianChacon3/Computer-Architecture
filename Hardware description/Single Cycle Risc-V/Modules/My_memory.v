`timescale 1ns / 1ps

module My_memory #(
    parameter N = 10,         // tamaño de dirección
    parameter M = 8,
    parameter FILENAME = ""
)(
    input clk, WE,
    input [N-1:0] A,
    input [M-1:0] WD,
    output reg [M-1:0] RD
);

    // Memoria
    reg [M-1:0] my_mem [0:(1<<N)-1];

    // Carga inicial del archivo
    initial begin
        if (FILENAME != "") begin
            $display("Cargando %s ...", FILENAME);
            $readmemh(FILENAME, my_mem);
        end
    end

    // Lectura combinacional  <-- ESTA ES LA CLAVE
    always @(*) begin
        RD = my_mem[A];
    end

    // Escritura sincrónica
    always @(posedge clk) begin
        if (WE)
            my_mem[A] <= WD;
    end
    
//02800613
//00100093
//00200113
//00300193
//00400213
//00500293
//00600313
//00700393
//00800413
//00900493
//40005283
//01450C63
//01851C63
//01C52C63
//02053C63
//02454C63
//02855C63
//02C56C63
//03057C63
//03458C63
//03859C63
//07E00593
//40B02023
//00060067
//03000593
//40B02023
//00060067
//06000593
//40B02023
//00060067
//07900593
//40B02023
//00060067
//03300593
//40B02023
//00060067
//05B00593
//40B02023
//00060067
//05F00593
//40B02023
//00060067
//07000593
//40B02023
//00060067
//0FF00593
//40B02023
//00060067
//07300593
//40B02023
//00060067
//00000033
//00000033
//00000033


endmodule
