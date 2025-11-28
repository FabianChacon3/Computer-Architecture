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

endmodule 
