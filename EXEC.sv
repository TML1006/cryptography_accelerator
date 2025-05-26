module EXEC(clk, reset, A, B, C, aluOp, maluOp, shaOp, execSrc, keyAssist, encryption, finalRound, wordSize, wordMemW, execResult, branchTaken, set_type);
	input logic [127:0] A, B, C;
	input logic [6:0] wordSize;
	input logic [3:0] aluOp, maluOp;
	input logic [2:0] shaOp;
	input logic [1:0] execSrc, set_type;
	input logic keyAssist, finalRound, encryption, wordMemW;
	input logic clk, reset;
	
	output logic [127:0] execResult;
	output logic branchTaken;

	logic [127:0] aluResult, aesResult, hashResult /*maluResult*/;
	
	
	ALU alu(.*);
	
	//MALU malu(.*);
	
	aesUnit aes(.*);

	shaUnit sha(.*);
	
	//Mux Output
	
	always_comb begin
		case(execSrc)
		
			2'd0: execResult = aluResult;
			
			//mod: execResult = maluResult;
			
			
			2'd2: execResult = aesResult;

			2'd3: execResult = hashResult;
		
		
			default: execResult = '0;
		endcase
	
	end
endmodule
