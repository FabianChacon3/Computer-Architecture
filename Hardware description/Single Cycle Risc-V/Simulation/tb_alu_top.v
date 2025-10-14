`timescale 1ns / 1ps

module tb_alu_top;

  // Entradas
  reg [31:0] A, B;
  reg [4:0]  shamt;
  reg [2:0]  funct3;
  reg [6:0]  funct7;
  reg [2:0]  ALUControl;

  // Salidas
  wire [31:0] Result;

  // Instancia de la ALU
  alu_top uut (
    .A(A),
    .B(B),
    .shamt(shamt),
    .funct3(funct3),
    .funct7(funct7),
    .ALUControl(ALUControl),
    .Result(Result)
  );



  // Estímulos
  initial begin
    // Inicialización
    A = 0; B = 0; shamt = 0; funct3 = 0; funct7 = 0; ALUControl = 0;
    #10;

    // Caso 1: suma
    A = 32'h00000005; B = 32'h00000003; ALUControl = 3'b000; // ADD
    #10;

    // Caso 2: resta
    A = 32'h0000000A; B = 32'h00000004; ALUControl = 3'b001; // SUB
    #10;

    // Caso 3: AND
    A = 32'hFFFF0000; B = 32'h00FF00FF; ALUControl = 3'b010; // AND
    #10;

    // Caso 4: OR
    A = 32'hF0F0F0F0; B = 32'h0F0F0F0F; ALUControl = 3'b011; // OR
    #10;

    // Caso 5: XOR
    A = 32'hAAAA5555; B = 32'h12345678; ALUControl = 3'b100; // XOR
    #10;

    // Caso 6: SHIFT (ejemplo)
    A = 32'h00000000; B = 32'h00000001; shamt = 5'd4; funct3 = 3'b001; funct7 = 7'b0000000; ALUControl = 3'b101; 
    #10;

    // Caso 7: COMP
    A = 32'h0000000F; B = 32'h0000000F; funct3 = 3'b000; funct7 = 7'b0000000; ALUControl = 3'b110;
    #10;

    // Fin simulación
    $finish;
  end

endmodule
