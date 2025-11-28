`timescale 1ns / 1ps

module PeriphSystem(
    input  wire        clk,
    input  wire        WE,              // Write Enable desde CPU
    input  wire [10:0] Address,         // Dirección completa
    input  wire [31:0] WriteData,       // Dato de escritura
    input  wire [3:0]  INPUTSP1,
    output wire [31:0] ReadData,         // Dato leído
    output wire [6:0]  READINGP1
);

    // ==============================
    //  Señales internas
    // ==============================

    wire sel_peripheral;        // Selector: 0 = Memoria, 1 = Periférico
    wire [9:0] addr_mem;   // Address[9:0] para memoria

    assign sel_peripheral = Address[10];
    assign addr_mem  = Address[9:0];

    // ------------------------------
    // Señales hacia memoria
    // ------------------------------
    wire        mem_WE;
    wire [31:0] mem_WriteData;
    wire [31:0] mem_ReadData;

    // ------------------------------
    // Señales hacia periférico 1
    // ------------------------------
    wire       p1_WE;
    wire [6:0] p1_WriteData;
    wire [3:0] p1_ReadData;

    // ==============================
    //  DEMUX para escritura
    // ==============================

    assign mem_WE        = (sel_peripheral == 1'b0) ? WE        : 1'b0;
    assign mem_WriteData = (sel_peripheral == 1'b0) ? WriteData : 32'b0;

    assign p1_WE         = (sel_peripheral == 1'b1) ? WE        : 1'b0;
    assign p1_WriteData  = (sel_peripheral == 1'b1) ? WriteData : 32'b0;

    // ==============================
    //  Instancia de la MEMORIA
    // ==============================

    Data_memory DataMemPh(
        .clk(clk),           
        .WE(mem_WE),            
        .A(addr_mem),  
        .WD(mem_WriteData), 
        .RD(mem_ReadData)
    );

    // ==============================
    //  Instancia del PERIFÉRICO
    // ==============================

    Periferic1 perif1_inst (
        .clk(clk),
        .WE(p1_WE),
        .INPUTSP1(INPUTSP1),
        .WriteData(p1_WriteData),
        .ReadData(p1_ReadData),
        .READINGP1(READINGP1)
    );

    // ==============================
    //  MUX para lectura
    // ==============================
    
    wire [31:0] p1Data;
    assign p1Data = {28'd0, p1_ReadData};

    assign ReadData = sel_peripheral ? p1Data : mem_ReadData;

endmodule

