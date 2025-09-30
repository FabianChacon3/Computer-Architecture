`timescale 1ns / 1ps
module Instruction_memory(
   input clk,WE,
   input [9:0] A,
   input  [31:0] WD,
   output wire [31:0] RD
  
    );
   
    
My_memory  my_ram0 (
        .clk(clk),
        .WE(WE),
        .A(A),
        .WD(WD[7:0]),
        .RD(RD[7:0])
    );
My_memory  my_ram1 (
        .clk(clk),
        .WE(WE),
        .A(A+1),
        .WD(WD[15:8]),
        .RD(RD[15:8])
    );
My_memory  my_ram2 (
        .clk(clk),
        .WE(WE),
        .A(A+2),
        .WD(WD[23:16]),
        .RD(RD[23:16])
    );
My_memory my_ram3 (
        .clk(clk),
        .WE(WE),
        .A(A+3),
        .WD(WD[31:24]),
        .RD(RD[31:24])
    );
endmodule
