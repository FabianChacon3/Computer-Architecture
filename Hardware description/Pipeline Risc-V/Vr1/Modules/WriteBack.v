`timescale 1ns / 1ps

module WriteBack(
    // Datapath
    input [31:0] ALUResultW, ReadDataW, ImmExtW,
    input [9:0] PCPlus4W,
    input [4:0] RdWin,
    output reg [31:0] Result,
    output [4:0] RdWout,
    
    // Control Unit
    input [1:0] ResultSrcW
    );
    
    always @(*) begin
        case (ResultSrcW)
            2'b00: Result = ALUResultW;
            2'b01: Result = ReadDataW;
            2'b10: Result = {{22{1'b0}}, PCPlus4W};
            2'b11: Result = ImmExtW;
            default: Result = 32'b0;
        endcase 
    end
    
    assign RdWout = RdWin;
    
endmodule
