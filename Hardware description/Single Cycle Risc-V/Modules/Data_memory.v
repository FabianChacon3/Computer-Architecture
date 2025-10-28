`timescale 1ns / 1ps
module Data_memory #(
    parameter N = 10,         // n�mero de bits para direcci�n (2^N posiciones)
    parameter M = 32         // n�mero de bits por palabra
)(
    input clk,
    input WE,
    input [N-1:0] A,  //adrrs
    input [M-1:0] WD,  // bits por palabra
    output reg [M-1:0] RD
);

    // Definimos la RAM
    reg [M-1:0] my_mem [0:(1<<N)-1];

    // Inicializamos desde archivo externo
// initial begin
//     $display(">>> Cargando memoria desde program.mem ...");
//     $readmemh("program2.mem", my_mem);
// end

    // Escritura s�ncrona / lectura s�ncrona
    always @(posedge clk) begin
        if (WE)
            my_mem[A] <= WD;  // escritura
        RD <= my_mem[A];     // lectura
    end

endmodule
