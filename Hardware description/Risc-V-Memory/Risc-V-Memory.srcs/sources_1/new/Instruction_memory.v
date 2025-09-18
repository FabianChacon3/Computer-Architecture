`timescale 1ns / 1ps
module Instruction_memory#(
    parameter N = 5, // 2^5 = 32 direcciones
    parameter M = 8 // 8 bits por palabra
    )(
   input clk,we,
   input [N-1:0] addr,
   input  [31:0] data_in,
   output wire [31:0] data_out
  
    );
   
    
My_memory #(
        .N(N),
        .M(M)
    ) my_ram0 (
        .clk(clk),
        .we(we),
        .addr(addr),
        .data_in(data_in[7:0]),
        .data_out(data_out[7:0])
    );
My_memory #(
        .N(N),
        .M(M)
    ) my_ram1 (
        .clk(clk),
        .we(we),
        .addr(addr),
        .data_in(data_in[15:8]),
        .data_out(data_out[15:8])
    );
My_memory #(
        .N(N),
        .M(M)
    ) my_ram2 (
        .clk(clk),
        .we(we),
        .addr(addr),
        .data_in(data_in[23:16]),
        .data_out(data_out[23:16])
    );
My_memory #(
        .N(N),
        .M(M)
    ) my_ram3 (
        .clk(clk),
        .we(we),
        .addr(addr),
        .data_in(data_in[31:24]),
        .data_out(data_out[31:24])
    );       
endmodule
