`timescale 1ns / 1ps
module tb_memory;

    reg clk;
    reg we;
    reg [7:0] addr;
    reg [7:0] data_in;
    wire [31:0] data_out;

    // Instancia de la RAM
    My_memory_n8 MyRAM (
        .clk(clk),
        .we(we),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Generar reloj
    always #5 clk = ~clk;

    integer i;

    initial begin
        $dumpfile("resultados_memo.vcd");
        $dumpvars(0, tb_memory);

        clk = 0;
        we = 0;
        data_in = 0;
        addr = 0;


        // Recorrer primeras 48 posiciones (donde cargaste el programa)
        for (i = 0; i < 68; i = i + 4) begin
            addr = i;
            #10;
            $display("ADDR=%0d DATA_OUT=%h", addr, data_out);
        end

        $finish;
    end
endmodule


                                                                     