module finalHash(A, set_type, outFinal);
	input logic [127:0] A;
	input logic [1:0] set_type;

	output logic [127:0] outFinal;

	always_comb begin
		case(set_type)
			2'd0: outFinal = {(A[127:64] + 64'h22312194FC2BF72C), (A[63:0] + 64'h9F555FA3C84C64C2)};
			2'd1: outFinal = {(A[127:64] + 64'h2393B86B6F53B151), (A[63:0] + 64'h963877195940EABD)};
			2'd2: outFinal = {(A[127:64] + 64'h96283EE2A88EFFE3), (A[63:0] + 64'hBE5E1E2553863992)};
			2'd3: outFinal = {(A[127:64] + 64'h2B0199FC2C85B8AA), (A[63:0] + 64'h0EB72DDC81C52CA2)};
		endcase
	end

endmodule