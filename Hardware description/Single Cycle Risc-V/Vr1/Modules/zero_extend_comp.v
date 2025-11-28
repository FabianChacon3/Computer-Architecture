`timescale 1ns / 1ps
module zero_extend_comp(
    input  wire [31:0] diff,
    input  wire [2 :0] funct3,
    output wire [31:0] result
);

    wire less, not_equal, equal, geq, slt;

    assign slt = diff[31];

    // OR 32?1 (ya la tienes implementada)
    wire or_out;
    or1 or1_inst ( 
        .a(diff),   
        .y(or_out)  
    );

    assign equal     = ~or_out;
    assign not_equal = or_out;

    assign less      = slt;
    assign geq       = ~slt;

    reg [31:0] comp_result;
    always @(*) begin
        case (funct3)
            3'b000: comp_result = {31'b0, equal};     // >=
            3'b001: comp_result = {31'b0, not_equal}; // !=
            3'b100: comp_result = {31'b0, less};      // <
            3'b101: comp_result = {31'b0, geq};       // >=
            default: comp_result = 32'b0;       //cualquier cosa
        endcase
    end

    assign result = comp_result;

endmodule

