`timescale 1ns / 1ps
module My_memory #(
    parameter N = 5,         // número de bits para dirección (2^N posiciones)
    parameter M = 8          // número de bits por palabra
)(
    input clk,
    input we,
    input [N-1:0] addr,
    input [M-1:0] data_in,
    output reg [M-1:0] data_out
);

    // Definimos la RAM
    reg [M-1:0] my_mem [0:(1<<N)-1];

    // Inicializamos desde archivo externo
// initial begin
//     $display(">>> Cargando memoria desde program.mem ...");
//     $readmemh("program2.mem", my_mem);
// end

    // Escritura síncrona / lectura síncrona
    always @(posedge clk) begin
        if (we)
            my_mem[addr] <= data_in;  // escritura
        data_out <= my_mem[addr];     // lectura
    end

endmodule
