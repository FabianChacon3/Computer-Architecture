`timescale 1ns / 1ps
module tb_Instruction_Memory;

   reg clk;
   reg WE;
   reg [9:0] A;
   reg [31:0] WD;
   wire [31:0] RD;
   integer i;

   // Instancia del módulo principal
   Instruction_memory uut (
      .clk(clk),
      .WE(WE),
      .A(A),
      .WD(WD),
      .RD(RD)
   );

   // Instrucciones a cargar
   reg [31:0] instructions [0:16];

   // Generar reloj
   always #5 clk = ~clk;

   initial begin
      clk = 0;
      WE = 0;
      A  = 0;
      WD = 0;

      // ===================================================
      // Cargar las instrucciones en memoria temporal
      // ===================================================
      instructions[0]  = 32'h010000df;
      instructions[1]  = 32'h0800006f;
      instructions[2]  = 32'h40000513;
      instructions[3]  = 32'h40e00593;
      instructions[4]  = 32'h000006b3;
      instructions[5]  = 32'h04b50863;
      instructions[6]  = 32'h00150613;
      instructions[7]  = 32'h00050e03;
      instructions[8]  = 32'h00060e83;
      instructions[9]  = 32'h03ce0d63;
      instructions[10] = 32'h01c60023;
      instructions[11] = 32'h01d50023;
      instructions[12] = 32'h00561593;
      instructions[13] = 32'h00551513;
      instructions[14] = 32'hffb9f06f;
      instructions[15] = 32'hf8069de3;
      instructions[16] = 32'h00008067;

      // ===================================================
      // Escribir las instrucciones en la memoria
      // ===================================================
      WE = 1;
      for (i = 0; i < 17; i = i + 1) begin
         A  = i << 2;         // dirección en bytes
         WD = instructions[i];
         #10;                 // pulso de reloj
      end
      WE = 0;

      // ===================================================
      // Leer las instrucciones
      // ===================================================
      $display("===========================================================================");
      $display("                   TESTBENCH: INSTRUCTION MEMORY RISC-V");
      $display("===========================================================================");
      $display("  Addr | PC(Dec) |   Instruction (Hex)   |          (Bin)           ");
      $display("--------------------------------------------------------------------------");

      for (i = 0; i < 17; i = i + 1) begin
         A = i << 2;
         #10;
         $display("  %02d   |  %04d   |   %08h   |  %032b", i, A, RD, RD);
      end

      $display("===========================================================================");
      $stop;
   end
endmodule
