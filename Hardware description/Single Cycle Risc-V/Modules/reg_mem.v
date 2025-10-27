`timescale 1ns / 1ps
module reg_mem (
    input  wire        clk,
    input  wire        WE,
    input  wire [4:0]  A1, A2, A3,
    input  wire [31:0] WD3,
    output wire [31:0] RD1, RD2
);

    // 32 registros de 32 bits (reg[31:0] r[0:31])
    reg [31:0] r [31:0];

    // Escritura sincr�nica
    always @(posedge clk) begin
        if (WE && (A3 != 5'd0))
            r[A3] <= WD3;
    end

    // Lectura combinacional
    assign RD1 = (A1 == 5'd0) ? 32'b0 : r[A1];
    assign RD2 = (A2 == 5'd0) ? 32'b0 : r[A2];

endmodule
