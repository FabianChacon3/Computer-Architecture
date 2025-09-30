`timescale 1ns / 1ps
module regfile (
    input  wire        clk,                 // reloj
    input  wire        WE3,                 // enable de escritura
    input  wire [4:0]  A1, A2, A3,           // direcciones
    input  wire [31:0] WD3,                  // dato de escritura
    output wire [31:0] RD1, RD2              // datos de lectura
);

    // Solo 31 registros físicos (del 1 al 31)
    reg [31:0] regs [31:1];

    // Lectura: si la dirección es 0 → 0
    assign RD1 = (A1 == 0) ? 32'b0 : regs[A1];
    assign RD2 = (A2 == 0) ? 32'b0 : regs[A2];

    // Escritura síncrona
    always @(posedge clk) begin
        if (WE3)
            regs[A3] <= WD3;
    end

endmodule
