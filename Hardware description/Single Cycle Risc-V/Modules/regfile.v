`timescale 1ns / 1ps
module regfile (
    input wire clk,                // Reloj
    input wire WE3,                // Enable de escritura
    input wire [4:0] A1, A2, A3,   // Direcciones (5 bits → 32 registros)
    input wire [31:0] WD3,         // Dato de escritura
    output wire [31:0] RD1, RD2    // Datos de lectura
);

    // Banco de 32 registros de 32 bits
    reg [31:0] regs [31:0];

    // Lectura asíncrona
    assign RD1 = regs[A1];
    assign RD2 = regs[A2];

    // Escritura síncrona (en flanco positivo del reloj)
    always @(posedge clk) begin
        if (WE3)        // opcional: evitar escribir en R0
            regs[A3] <= WD3;
    end

endmodule