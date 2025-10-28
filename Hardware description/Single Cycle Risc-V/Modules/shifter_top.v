`timescale 1ns / 1ps

module shifter_top (
    input  wire [31:0] A,          // dato de entrada
    input  wire [4:0]  shamt,       // desplazamiento
    input  wire funct3_2,      // 001=SLL, 101=SRL/SRA
    input  wire funct7,      // bit[5] distingue SRA de SRL
    output wire [31:0] outshift
);

    wire arith = funct7;         // activa sign extend en SRA
    wire fill  = arith ? A[31] : 1'b0; // bit de relleno (signo o 0)
	
	wire [31:0] Ainv;
	
	assign Ainv = {A[0], A[1], A[2], A[3], A[4], A[5], A[6], A[7],
            A[8], A[9], A[10], A[11], A[12], A[13], A[14], A[15],
            A[16], A[17], A[18], A[19], A[20], A[21], A[22], A[23],
            A[24], A[25], A[26], A[27], A[28], A[29], A[30], A[31]};
	
	wire [31:0] in = funct3_2 ? Ainv : A;

    // Generamos las 32 versiones desplazadas
	wire [31:0] shift0  = in;
    wire [31:0] shift1  = {in[30:0],       fill};
	wire [31:0] shift2  = {in[29:0],     {2{fill}}};
	wire [31:0] shift3  = {in[28:0],     {3{fill}}};
	wire [31:0] shift4  = {in[27:0],     {4{fill}}};
	wire [31:0] shift5  = {in[26:0],     {5{fill}}};
	wire [31:0] shift6  = {in[25:0],     {6{fill}}};
	wire [31:0] shift7  = {in[24:0],     {7{fill}}};
	wire [31:0] shift8  = {in[23:0],     {8{fill}}};
	wire [31:0] shift9  = {in[22:0],     {9{fill}}};
	wire [31:0] shift10 = {in[21:0],    {10{fill}}};
	wire [31:0] shift11 = {in[20:0],    {11{fill}}};
	wire [31:0] shift12 = {in[19:0],    {12{fill}}};
	wire [31:0] shift13 = {in[18:0],    {13{fill}}};
	wire [31:0] shift14 = {in[17:0],    {14{fill}}};
	wire [31:0] shift15 = {in[16:0],    {15{fill}}};
	wire [31:0] shift16 = {in[15:0],    {16{fill}}};
	wire [31:0] shift17 = {in[14:0],    {17{fill}}};
	wire [31:0] shift18 = {in[13:0],    {18{fill}}};
	wire [31:0] shift19 = {in[12:0],    {19{fill}}};
	wire [31:0] shift20 = {in[11:0],    {20{fill}}};
	wire [31:0] shift21 = {in[10:0],    {21{fill}}};
	wire [31:0] shift22 = {in[9:0],     {22{fill}}};
	wire [31:0] shift23 = {in[8:0],     {23{fill}}};
	wire [31:0] shift24 = {in[7:0],     {24{fill}}};
	wire [31:0] shift25 = {in[6:0],     {25{fill}}};
	wire [31:0] shift26 = {in[5:0],     {26{fill}}};
	wire [31:0] shift27 = {in[4:0],     {27{fill}}};
	wire [31:0] shift28 = {in[3:0],     {28{fill}}};
	wire [31:0] shift29 = {in[2:0],     {29{fill}}};
	wire [31:0] shift30 = {in[1:0],     {30{fill}}};
	wire [31:0] shift31 = {in[0],       {31{fill}}};
	
	reg [31:0] out;
	
	always @(*) begin
		case (shamt)
			5'd0:  out = shift0;
			5'd1:  out = shift1;
			5'd2:  out = shift2;
			5'd3:  out = shift3;
			5'd4:  out = shift4;
			5'd5:  out = shift5;
			5'd6:  out = shift6;
			5'd7:  out = shift7;
			5'd8:  out = shift8;
			5'd9:  out = shift9;
			5'd10: out = shift10;
			5'd11: out = shift11;
			5'd12: out = shift12;
			5'd13: out = shift13;
			5'd14: out = shift14;
			5'd15: out = shift15;
			5'd16: out = shift16;
			5'd17: out = shift17;
			5'd18: out = shift18;
			5'd19: out = shift19;
			5'd20: out = shift20;
			5'd21: out = shift21;
			5'd22: out = shift22;
			5'd23: out = shift23;
			5'd24: out = shift24;
			5'd25: out = shift25;
			5'd26: out = shift26;
			5'd27: out = shift27;
			5'd28: out = shift28;
			5'd29: out = shift29;
			5'd30: out = shift30;
			5'd31: out = shift31;
			default: out = 32'b0;
		endcase
	end


	wire [31:0] outinv;
	assign outinv = {out[0], out[1], out[2], out[3], out[4], out[5], out[6], out[7],
			 out[8], out[9], out[10], out[11], out[12], out[13], out[14], out[15],
			 out[16], out[17], out[18], out[19], out[20], out[21], out[22], out[23],
			 out[24], out[25], out[26], out[27], out[28], out[29], out[30], out[31]};



	assign outshift = funct3_2 ? outinv : out;


endmodule
