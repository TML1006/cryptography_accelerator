module instrDec(instruction, opCode, rs1, rs2, rs3, rd, funct7, funct3, set_type, imm12, imm7, imm5, round, branchOffset);
	//Instruction Input
	input logic [31:0] instruction;
	
	//Branch offset Logic
	output logic [63:0] branchOffset;

	//Immediates Output Logic
	output logic [11:0] imm12;
	output logic [6:0] imm7;
	output logic [4:0] imm5, round;
	
	//Registers & OpCodes
	output logic [6:0] opCode, funct7;
	output logic [4:0] rs1, rs2, rs3, rd; 
	output logic [2:0] funct3;
	output logic [1:0] set_type;
	
	//Registers & OpCodes Decoded
	assign opCode = instruction[6:0];
	assign rs1 = instruction[19:15];
	assign rs2 = instruction[24:20];
	assign rs3 = instruction[29:25];
	assign rd = instruction[11:7];
	assign funct7 = instruction[31:25];
	assign funct3 = instruction[14:12];

	//SHA SET_TYPE
	assign set_type = instruction[31:30];

	//Branch Reconstruction
	assign branchOffset = {{51{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
	
	//Immediates Decoded
	assign imm12 = instruction[31:20];
	assign imm7 = instruction[31:25];
	assign imm5 = instruction[11:7];
	assign round = instruction[24:20];

endmodule
