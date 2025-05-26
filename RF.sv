module RF(clk, reset, rs1, rs2, rs3, rd, ReadData1, ReadData2, ReadData3, B, execResult, writeEnable, opCode, funct7, funct3, reg2Loc, aluSRC, 
			 encryption, keyAssist, finalRound, aluOp, maluOp, shaOp, execSrc, memWrite, memOrExec, 
			 wordSize, wordMemW, read_enable, imm12, imm7, imm5, round);
	input logic clk, reset;
	input logic [127:0] execResult;
	input logic [11:0] imm12;
	input logic [6:0] opCode, funct7, imm7;
	input logic [4:0] rs1, rs2, rs3, rd, imm5, round;
	input logic [2:0] funct3;
	
	output logic [127:0] ReadData1, ReadData2, ReadData3, B;
	output logic [6:0] wordSize;
	output logic [3:0] aluOp, maluOp;
	output logic [2:0] shaOp;
	output logic [1:0] aluSRC, execSrc;
	output logic keyAssist, encryption, writeEnable, reg2Loc, memWrite, memOrExec, finalRound, wordMemW, read_enable;
	
	logic [127:0] SE_imm12, SE_imm7, SE_imm5, ZE_round;
	
	controlLogic cl(.*);
	
	//clk, reset, ReadReg1, ReadReg2, WriteReg, WriteData, WriteEnable, ReadData1, ReadData2
	registerFile regFile(.clk, .reset, .ReadReg1(rs1), .ReadReg2(rs2), .ReadReg3(rs3), .WriteReg(rd), .WriteData(execResult), .WriteEnable(writeEnable), .ReadData1, .ReadData2, .ReadData3);
	
	//Sign Extensions
	assign SE_imm12[127:12] = {115{1'b0}};
	assign SE_imm12[11:0] = imm12;
	
	assign SE_imm7[127:7] = {121{imm7[6]}};
	assign SE_imm7[6:0] = imm7;
	
	assign SE_imm5[127:5] = {122{imm5[4]}};
	assign SE_imm5[4:0] = imm5;
	
	assign ZE_round[127:5] = {122{1'b0}};
	assign ZE_round[4:0] = round;
	
	always_comb begin
		case(aluSRC)
		
			2'd0: B = ReadData2;
		
			2'd1: B = SE_imm12;
			
			2'd2: B = ZE_round;
		
		endcase
	
	end
	

endmodule
