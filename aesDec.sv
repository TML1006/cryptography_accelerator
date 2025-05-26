module aesDec(A, B, finalRound, outArrayDec);
	input logic [127:0] A, B;
	input logic finalRound;
	
	output logic [7:0] outArrayDec [3:0][3:0];
	
//	output logic [7:0] srIn1 [3:0][3:0];
//   output logic [7:0] sbIn1 [3:0][3:0];
//   output logic [7:0] sbOut [3:0][3:0];
//	output logic [7:0] roundKey [3:0][3:0];
//   output logic [7:0] mixColOut [3:0][3:0];
	
	logic [7:0] srIn1 [3:0][3:0];
   logic [7:0] sbIn1 [3:0][3:0];
   logic [7:0] sbOut [3:0][3:0];
	logic [7:0] roundKey [3:0][3:0];
   logic [7:0] mixColOut [3:0][3:0];
	
	integer i, j;

   // Unpack 128-bit input A into 4x4 byte matrix [row][col]
	always_comb begin
		for (i = 0; i < 4; i++) begin
			for (j = 0; j < 4; j++) begin
				srIn1[i][j] = A[127 - ((4 * j + i) * 8) -: 8];
				roundKey[i][j] = B[127 - ((4 * j + i) * 8) -: 8];
			end
		end
	end

	//Inverse Shift Rows
	invShiftRows invSR(.in(srIn1), .out(sbIn1));
	
	//Inverse Sub Bytes
	sboxInvSb invSbox(.in(sbIn1), .out(sbOut));
	
//	output logic [7:0] col_in [3:0][3:0];
//   output logic [7:0] col_out [3:0][3:0];
	logic [7:0] col_in [3:0][3:0];
	logic [7:0] col_out [3:0][3:0];
	
	// Extract columns from mixColIn
   always_comb begin
		for (int col = 0; col < 4; col++) begin
			for (int row = 0; row < 4; row++) begin
				col_in[col][row] = (sbOut[row][col] ^ roundKey[row][col]);
         end
		end
	end

   // Instantiate mixColumns_col per column
   generate
		genvar c;
      for (c = 0; c < 4; c++) begin : mix_col_gen
			invMixColumns_col mCol(
					.col_i(col_in[c]),
					.col_o(col_out[c])
					);
		end
	endgenerate

   // Reassemble matrix from mixCol output columns
	always_comb begin
		for (int row = 0; row < 4; row++) begin
			for (int col = 0; col < 4; col++) begin
				mixColOut[row][col] = col_out[col][row];
         end
		end
	end
	
always_comb begin
    for (int row = 0; row < 4; row++) begin
        for (int col = 0; col < 4; col++) begin
            outArrayDec[row][col] = finalRound ? col_in[col][row] : mixColOut[row][col];
        end
    end
end


endmodule

module aesDec_testbench();
	logic [127:0] A, B;
	logic [7:0] outArrayDec [3:0][3:0];
	logic finalRound;
	
//	logic [7:0] srIn1 [3:0][3:0];
//   logic [7:0] sbIn1 [3:0][3:0];
//   logic [7:0] sbOut [3:0][3:0];
//	logic [7:0] roundKey [3:0][3:0];
//   logic [7:0] mixColOut [3:0][3:0];
//	logic [7:0] col_in [3:0][3:0];
//   logic [7:0] col_out [3:0][3:0];
	
	//assign xored = 128'h29c3505f571420f6402299b31a02d73a ^ 128'h28fddef86da4244accc0a4fe3b316f26;
	
	aesDec DUT(.*);
	
	initial begin
//		A = (128'h3925841d02dc09fbdc118597196a0b32 ^ 128'hd014f9a8c9ee2589e13f0cc8b6630ca6);
//		B = 128'hac7766f319fadc2128d12941575c006e;
//		finalRound = 0;
//		#10;
//		
//		A = 128'h473794ed40d4e4a5a3703aa64c9f42bc;
//		B = 128'head27321b58dbad2312bf5607f8d292f;
//		finalRound = 0;
//		#10;
		
		A = 128'h52a4c894_85116a28_e3cf2fd7_f6505e07;
		B = 128'h3d80477d_4716fe3e_1e237e44_6d7a883b;
		finalRound = 0;
		#10;
		
		$stop;
	end
	
	
endmodule
