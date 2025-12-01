`timescale 1ns / 1ps
module My_memory #(
    parameter N = 10,         // número de bits para dirección (2^N posiciones)
    parameter M = 8          // número de bits por palabra
)(
    input clk, WE,
    input [N-1:0] A,
    input [M-1:0] WD,
    output reg [M-1:0] RD
);

    // Definimos la RAM
    reg [M-1:0] my_mem [0:(1<<N)-1];

    always @(posedge clk) begin
        if (WE)
            my_mem[A] <= WD;  // escritura     
        RD <= my_mem[A]; // lectura
    end

endmodule
