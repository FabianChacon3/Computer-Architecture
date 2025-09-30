`timescale 1ns / 1ps
module ImmExt (
    input  [31:0] instr,
    input  [1:0]  ImmSrc,
    output reg [31:0] imm_ext
);

always @(*) begin
    case (ImmSrc)
        // -----------------------------
        // I-type: imm = sign-extend(instr[31:20])
        // -----------------------------
        2'b00: imm_ext = {{20{instr[31]}}, instr[31:20]};

        // -----------------------------
        // S-type o U-type:
        // Diferenciamos con bit4 del opcode (instr[6:0][4])
        // -----------------------------
        2'b01: begin
            if (instr[4] == 1'b0) begin
                // S-type: imm = sign-extend({instr[31:25], instr[11:7]})
                imm_ext = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            end else begin
                // U-type: imm = {instr[31:12], 12'b0}
                imm_ext = {instr[31:12], 12'b0};
            end
        end

        // -----------------------------
        // B-type: branch offset
        // imm = sign-extend({instr[31], instr[7], instr[30:25], instr[11:8], 1'b0})
        // -----------------------------
        2'b10: imm_ext = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};

        // -----------------------------
        // J-type: jump offset
        // imm = sign-extend({instr[31], instr[19:12], instr[20], instr[30:21], 1'b0})
        // -----------------------------
        2'b11: imm_ext = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};

        // Default (no usado)
        default: imm_ext = 32'b0;
    endcase
end

endmodule

