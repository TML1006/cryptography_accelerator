`timescale 1ns/10ps
module crypto_accelerator(clk, reset);
	input logic clk, reset;
	
	logic [127:0] ReadData1, ReadData2, ReadData3, execResult, SE_imm12, SE_imm7, SE_imm5, ZE_round, B;
	logic [63:0] PC;
	logic [31:0] instruction;
	logic [11:0] imm12;
	logic [6:0] opCode, funct7, imm7, wordSize, t;
	
	logic [4:0] rs1, rs2, rs3, rd, imm5, round; 
	logic [3:0] aluOp, maluOp; 
	logic [2:0] shaOp;
	logic [2:0] funct3;
	logic [1:0] aluSRC, execSrc, set_type;
	logic keyAssist, encryption, writeEnable, reg2Loc, memWrite, memOrExec, finalRound, wordMemW, read_enable, branchTaken;
	//Start single cycle
	
	
	//Instruction Stag	

	IF instr(.*);
	
	//IFtoRF if2rf(); // Transition 1
	
	//Reg/Dec Stage
	
	RF rf(.*);
	
	//RFtoEX rf2ex(); // Transition 2
	
	//Execution Stage
	
	EXEC ex(.clk, .reset, .A(ReadData1), .B, .C(ReadData3), .aluOp, .maluOp, .shaOp, .execSrc, .keyAssist, .encryption, .finalRound, .wordSize, .wordMemW, .execResult, .branchTaken, .set_type);
	
	//EXTOMEM ex2mem(.*); //Transition 3
	
	//Mem
	
	//Ignore memory for now. Not entirely necessary
	//MEM mem();
	
	//MEMtoWB mem2wb(); // Transition 4
	//Write
	
	//WB();

endmodule

module crypto_testbench();
	logic clk, reset;
	
	crypto_accelerator DUT(.*);
	
	
	parameter CLOCK_PERIOD = 2;
	initial begin
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  // forever toggle the clock
	end
	
	// test
	initial begin
		reset <= 1;			@(posedge clk);
		reset <= 0;			@(posedge clk);
								repeat(1500) @(posedge clk);
		$stop;
	end
endmodule 