`include "mixColumns_sub.sv"

module aesUnit(A, B, keyAssist, encryption, finalRound, aesResult);

	input  logic [127:0] A, B;
   	input  logic keyAssist, finalRound, encryption;
	output logic [127:0] aesResult;

   	logic [127:0] keyAssistOut, roundOut;
	logic [7:0] outArrayEnc [3:0][3:0];
	logic [7:0] outArrayDec [3:0][3:0];
	logic [7:0] outArrayFin [3:0][3:0];
	
	aesEnc enc(.*);
	
	aesDec dec(.*);
	
	always_comb begin
    outArrayFin = encryption ? outArrayEnc : outArrayDec;
	end

   // Repack 4x4 byte matrix into 128-bit output
   assign roundOut = {
       outArrayFin[0][0], outArrayFin[1][0], outArrayFin[2][0], outArrayFin[3][0],
       outArrayFin[0][1], outArrayFin[1][1], outArrayFin[2][1], outArrayFin[3][1],
       outArrayFin[0][2], outArrayFin[1][2], outArrayFin[2][2], outArrayFin[3][2],
       outArrayFin[0][3], outArrayFin[1][3], outArrayFin[2][3], outArrayFin[3][3]
   };

   // Key expansion
   keyExpansion keyExpand(.key(A), .round(B), .roundKey(keyAssistOut));

   // Output logic
   assign aesResult = keyAssist ? keyAssistOut : roundOut;

endmodule


module aesUnit_testbench();
	logic [127:0] A, B, aesResult;
	logic keyAssist, finalRound, encryption;
	
	aesUnit DUT(.*);
	
	initial begin
		A = 128'ha0fafe1788542cb123a339392a6c7605;
		//A = 128'h49206C6F76652042656C6C6121212121;
		B = 128'd1;
		keyAssist = 1;
		finalRound = 0;
		encryption = 1;
		#10;
		
//		A = 128'h001F0E543C4E08596E221B0B4774311A;
//		//A = 128'h49206C6F76652042656C6C6121212121;
//		B = 128'h5468617473206d79204b756e67204675;
//		keyAssist = 0;
//		finalRound = 1;
//		//encryption = 0; 
//		#10;
		$stop;
	end
endmodule
