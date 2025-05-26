module setHashes(A, B, C, set_type, newHashes);
	input logic [127:0] A, B, C;
	input logic [1:0] set_type;

	output logic [127:0] newHashes;

	typedef enum logic [1:0] {
	SET1 = 2'b00,
	SET2 = 2'b01,
	SET3 = 2'b10
	} setTypes;
	


	always_comb begin
		case(set_type)
			SET1: begin
			//newHashes[63:0]  = B[127:64]; //h=g or d=c
			//newHashes[127:0] =  A[63:0]; //g=f or c=b
			newHashes = {A[63:0], B[127:64]};
			end

			SET2: begin
				//newHashes[63:0] = B[127:64]; //f=e
				//newHashes[127:0] = A[63:0] + C[63:0]; //d+T1
				newHashes = {(A[63:0] + C[63:0]), B[127:64]};
			end

			SET3: begin
				//newHashes[63:0] = A[127:64]; //b=a
				//newHashes[127:0] = B[63:0] + C[63:0]; //T1+T2
				newHashes = {(B[63:0] + C[63:0]), A[127:64]};
			end
		endcase
	end
endmodule