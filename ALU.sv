module ALU(A, B, aluOp, wordSize, aluResult, branchTaken);
	input  logic [127:0] A, B;
	input  logic [3:0] aluOp;
	input  logic [6:0]  wordSize;  // max of 127, so 7 bits is enough

	output logic [127:0] aluResult;
	output logic branchTaken;
	typedef enum logic [3:0] {
		ADD = 4'd0, SUB = 4'd1, XOR = 4'd2, OR = 4'd3,
		AND = 4'd4, SLL = 4'd5, SRL = 4'd6, ROR = 4'd7, 
		ROL = 4'd8, BLE=4'd9
	} aluOp_t;

	always_comb begin
		aluResult = 128'd0;
		branchTaken = 1'b0;
		case (aluOp)
			ADD: aluResult = $signed(A) + $signed(B);
			SUB: aluResult = $signed(A) - $signed(B);
			XOR: aluResult = A ^ B;
			OR:  aluResult = A | B;
			AND: aluResult = A & B;
			SLL: aluResult = A << B;
			SRL: aluResult = A >> B;
			ROR: aluResult = (A >> B) | (A << (wordSize - B));
			ROL: aluResult = (A << B) | (A >> (wordSize - B));
			BLE: branchTaken = (A <= B);
			default: aluResult = '0;
		endcase
	end
endmodule
