module aesEnc(A, B, finalRound, outArrayEnc);
	input logic [127:0] A, B;
	input logic finalRound;

	output logic [7:0] outArrayEnc [3:0][3:0];

   logic [7:0] srIn1 [3:0][3:0];
   logic [7:0] sbIn1 [3:0][3:0];
   logic [7:0] mixColIn [3:0][3:0];
   logic [7:0] mixColOut [3:0][3:0];
	logic [7:0] mixColInXor [3:0][3:0];
   logic [7:0] mixColOutXor [3:0][3:0];
	logic [7:0] roundKey [3:0][3:0];
	
   integer i, j;

   // Unpack 128-bit input A into 4x4 byte matrix [row][col]
   always_comb begin
		for (j = 0; j < 4; j++) begin
			for (i = 0; i < 4; i++) begin
				sbIn1[i][j] = A[127 - ((4 * j + i) * 8) -: 8];
				roundKey[i][j] = B[127 - ((4 * j + i) * 8) -: 8];
			end
		end
	end

	// SubBytes
	subBytes sByte1(.in(sbIn1), .out(srIn1));

	// ShiftRows
	shiftRows sRow1(.in(srIn1), .out(mixColIn));

   // --- Fixed MixColumns Section ---

   // Temp arrays for columns
   logic [7:0] col_in [3:0][3:0];
   logic [7:0] col_out [3:0][3:0];

   // Extract columns from mixColIn
   always_comb begin
		for (int col = 0; col < 4; col++) begin
			for (int row = 0; row < 4; row++) begin
				col_in[col][row] = mixColIn[row][col];
         end
		end
	end

   // Instantiate mixColumns_col per column
   generate
		genvar c;
      for (c = 0; c < 4; c++) begin : mix_col_gen
			mixColumns_col mCol(
					.col_i(col_in[c]),
					.col_o(col_out[c])
					);
		end
	endgenerate

   // Reassemble matrix from mixCol output columns
	always_comb begin
		for (int col = 0; col < 4; col++) begin
			for (int row = 0; row < 4; row++) begin
				mixColOut[row][col] = col_out[col][row];
         end
		end
	end
	

	//XOR roundkey
	always_comb begin
		for (int col = 0; col < 4; col++) begin
			for (int row = 0; row < 4; row++) begin
				mixColInXor[row][col] = mixColIn[row][col] ^ roundKey[row][col];
				mixColOutXor[row][col] = mixColOut[row][col] ^ roundKey[row][col];
			end
		end
	end
	
   // Final round conditional logic
	always_comb begin
		assign outArrayEnc = finalRound ? mixColInXor : mixColOutXor;
	end

endmodule
