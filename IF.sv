module IF(clk, reset, branchTaken, opCode, rs1, rs2, rs3, rd, funct7, set_type, funct3, imm12, imm7, imm5, round);
	input logic clk, reset, branchTaken;
	
	logic [63:0] PC, branchOffset;
	logic [31:0] instruction;
	
	output logic [11:0] imm12;
	output logic [6:0] imm7;
	output logic [4:0] imm5, round;
	
	//Registers & OpCodes
	output logic [6:0] opCode, funct7;
	output logic [4:0] rs1, rs2, rs3, rd; 
	output logic [2:0] funct3;
	output logic [1:0] set_type;
	
	//Risc-V OpCode Structure
	
	//Program Counter
	programCounter pc(.clk, .reset, .branchTaken, .branchOffset, .PC);
	
	//Fetch Instruction at address : PC
	instructmem instructionMem(.address(PC), .instruction, .clk);
	
	//opCode, rs1, rs2, rd, funct7, funct3, imm12, imm7, imm5
	//Deconstruct instruction into opcode and all possible components
	instrDec instructionDecode(.*);
	

endmodule
