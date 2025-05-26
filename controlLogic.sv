module controlLogic(opCode, funct7, funct3, reg2Loc, aluSRC, encryption, keyAssist, finalRound, aluOp, maluOp, shaOp, execSrc, writeEnable, memWrite, memOrExec, wordSize, wordMemW, read_enable);
	
	input logic [6:0] opCode, funct7;
	input logic [2:0] funct3;
	
	output logic [6:0] wordSize;
	output logic [3:0] aluOp, maluOp;
	output logic [2:0] shaOp;
	output logic [1:0] aluSRC, execSrc;
	output logic keyAssist, encryption, writeEnable, reg2Loc, memWrite, memOrExec, finalRound, read_enable, wordMemW;
	
	typedef enum logic [2:0] {
    ADD_SUB = 3'b000,
    XOR     = 3'b001,
    OR      = 3'b010,
    AND     = 3'b011,
    sll     = 3'b100,
    srl     = 3'b101,
    ror     = 3'b110,
    rol     = 3'b111
	} funct3_rtype_t;

	typedef enum logic [2:0] {
    ADDI    = 3'b000,
    andi    = 3'b011,
    slli    = 3'b100,
    srli    = 3'b101,
    rori    = 3'b110
	} funct3_itype_t;

	typedef enum logic [2:0] {
	aesEncryption = 3'b000,
	keyExpandRound = 3'b001,
	aesDecryption = 3'b010
	} funct3_aes_type;

	typedef enum logic [2:0] {
	MSG_ROUND = 3'b000,
	T1 = 3'b001,
	T2 = 3'b010,
	ADDHASH = 3'b011,
	SETHASH = 3'b100,
	FINALHASH = 3'b101
	} funct3_sha_type;

	typedef enum logic [6:0] {
	AES_CRYPTO = 7'b1100011,
	SHA_CRYPTO = 7'b1101111,
	R_TYPE = 7'b0110011,
	I_TYPE = 7'b0010011,
	LOAD = 7'b0000011,
	STUR = 7'b0100011
	} opTypes;

	typedef enum logic [2:0]{
		BLE = 3'b011
	} branch_types;


	
	always_comb begin
		case(opCode)
			
			//AES Cryptography
			AES_CRYPTO: begin 
				case(funct3)
					//AES Encryption & Key Generation
					aesEncryption: begin 
						if(funct7 == 7'h00) begin //regRoundEnc
							keyAssist = 1'b0;
							encryption = 1'b1;
							writeEnable = 1'b1;
							aluSRC = 2'd0;
							reg2Loc = 1'b1;
							memWrite = 1'b0;
							memOrExec = 1'b1; //1 = Exec gets written
							finalRound = 1'b0;
							execSrc = 2'b10; //AES Unit
							wordSize = 7'd64;
							aluOp = 4'bxxxx;
							maluOp = 4'bxxxx;
							shaOp = 3'd0;
							wordMemW = 1'b0;
							read_enable = 1'b0;
						end
						
						else begin //finalRoundEnc
							keyAssist = 0;
							encryption = 1;
							writeEnable = 1;
							aluSRC = 2'd0;
							reg2Loc = 1;
							memWrite = 0;
							memOrExec = 1; //1 = Exec gets written
							finalRound = 1;
							execSrc = 2'b10; //AES Unit
							wordSize = 7'd64;
							aluOp = 4'bxxxx;
							maluOp = 4'bxxxx;
							shaOp = 3'd0;
							wordMemW = 1'b0;
							read_enable = 0;
						end
						
					
					end
					
					
					keyExpandRound: begin
						keyAssist = 1;
						encryption = 1'bx;
						writeEnable = 1;
						aluSRC = 2'd2;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 0;
						execSrc = 2'b10; //AES Unit
						wordSize = 7'd64;
						aluOp = 4'bxxxx;
						maluOp = 4'bxxxx;
						shaOp = 3'd0;
						wordMemW = 1'b0;
						read_enable = 0;
				
					end
					
					//AES Decryption
					aesDecryption: begin
						if(funct7 == 7'h00) begin //regRoundDec
							keyAssist = 0;
							encryption = 0;
							writeEnable = 1;
							aluSRC = 2'd0;
							reg2Loc = 1;
							memWrite = 0;
							memOrExec = 1; //1 = Exec gets written
							finalRound = 0;
							execSrc = 2'b10; //AES Unit
							wordSize = 7'd64;
							aluOp = 4'bxxxx;
							maluOp = 4'bxxxx;
							shaOp = 3'd0;
							wordMemW = 1'b0;
							read_enable = 0;
						end
						
						
						else begin //finalRoundDec
							keyAssist = 0;
							encryption = 0;
							writeEnable = 1;
							aluSRC = 2'd0;
							reg2Loc = 1;
							memWrite = 0;
							memOrExec = 1; //1 = Exec gets written
							finalRound = 1;
							execSrc = 2'b10; //AES Unit
							wordSize = 7'd64;
							aluOp = 4'bxxxx;
							maluOp = 4'bxxxx;
							shaOp = 3'd0;
							wordMemW = 1'b0;
							read_enable = 0;
						end
					
					end
					
					//Branch Instruction : A < B
					BLE: begin
						keyAssist = 0;
						encryption = 0;
						writeEnable = 0;
						aluSRC = 2'd0;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 0;
						execSrc = 2'd0; //AES Unit
						wordSize = 7'd64;
						aluOp = 4'd9;
						maluOp = 4'bxxxx;
						shaOp = 3'd0;
						wordMemW = 1'b0;
						read_enable = 0;

					end
					
				endcase
			end

			//SHA Cryptography
			SHA_CRYPTO: begin
				case(funct3)
					MSG_ROUND: begin
						keyAssist = 0;
						encryption = 0;
						writeEnable = 0;
						aluSRC = 2'd0;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 1;
						execSrc = 2'd3; //AES Unit
						wordSize = 7'd64;
						aluOp = 4'bxxxx;
						maluOp = 4'bxxxx;
						shaOp = 3'd0;
						wordMemW = 1'b1;
						read_enable = 0;

					end

					T1: begin
						keyAssist = 0;
						encryption = 0;
						writeEnable = 1;
						aluSRC = 2'd0;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 1;
						execSrc = 2'd3; //AES Unit
						wordSize = 7'd64;
						aluOp = 4'bxxxx;
						maluOp = 4'bxxxx;
						shaOp = 3'd1;
						wordMemW = 1'b0;
						read_enable = 0;
					end

					T2: begin
						keyAssist = 0;
						encryption = 0;
						writeEnable = 1;
						aluSRC = 2'd0;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 1;
						execSrc = 2'd3; //AES Unit
						wordSize = 7'd64;
						aluOp = 4'bxxxx;
						maluOp = 4'bxxxx;
						shaOp = 3'd2;
						wordMemW = 1'b0;
						read_enable = 0;

					end

					ADDHASH: begin
						keyAssist = 0;
						encryption = 0;
						writeEnable = 1;
						aluSRC = 2'd0;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 1;
						execSrc = 2'd3; //AES Unit
						wordSize = 7'd64;
						aluOp = 4'bxxxx;
						maluOp = 4'bxxxx;
						shaOp = 3'd3;
						wordMemW = 1'b0;
						read_enable = 0;

					end


					SETHASH: begin
						keyAssist = 0;
						encryption = 0;
						writeEnable = 1;
						aluSRC = 2'd0;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 0;
						execSrc = 2'd3; //AES Unit
						wordSize = 7'd64;
						aluOp = 4'bxxxx;
						maluOp = 4'bxxxx;
						shaOp = 3'd4;
						wordMemW = 1'b0;
						read_enable = 0;

					end

					FINALHASH: begin
						keyAssist = 0;
						encryption = 0;
						writeEnable = 1;
						aluSRC = 2'd0;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 0;
						execSrc = 2'd3; //AES Unit
						wordSize = 7'd64;
						aluOp = 4'bxxxx;
						maluOp = 4'bxxxx;
						shaOp = 3'd5;
						wordMemW = 1'b0;
						read_enable = 0;
					end
				endcase // funct3

			end



				
			 //R-type Instructions
			 R_TYPE: begin 
				case(funct3)
					
					ADD_SUB: begin 
						if(funct7 == 7'h00) begin
							keyAssist = 0;
							encryption = 0;
							writeEnable = 1;
							aluSRC = 2'd0;
							reg2Loc = 1;
							memWrite = 0;
							memOrExec = 1; //1 = Exec gets written
							finalRound = 1;
							execSrc = 2'd0; //ALU Unit
							wordSize = 7'd64;
							aluOp = 4'd0;
							maluOp = 4'bxxxx;
							shaOp = 3'd0;
							wordMemW = 1'b0;
							read_enable = 0;
						end
						
						else begin
							keyAssist = 0;
							encryption = 0;
							writeEnable = 1;
							aluSRC = 2'd0;
							reg2Loc = 1;
							memWrite = 0;
							memOrExec = 1; //1 = Exec gets written
							finalRound = 1;
							execSrc = 2'd0; //AlU Unit
							wordSize = 7'd64;
							aluOp = 4'd1;
							maluOp = 4'bxxxx;
							shaOp = 3'd0;
							wordMemW = 1'b0;
							read_enable = 0;
						
						end

					end
					
					
					XOR: begin
						keyAssist = 0;
						encryption = 0;
						writeEnable = 1;
						aluSRC = 2'd0;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 1;
						execSrc = 2'd0; //ALU Unit
						wordSize = 7'd64;
						aluOp = 4'd2;
						maluOp = 4'bxxxx;
						shaOp = 3'd0;
						wordMemW = 1'b0;
						read_enable = 0;
					
					end
					
					
					OR: begin
						keyAssist = 0;
						encryption = 0;
						writeEnable = 1;
						aluSRC = 2'd0;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 1;
						execSrc = 2'd0; //ALU Unit
						wordSize = 7'd64;
						aluOp = 4'd3;
						maluOp = 4'bxxxx;
						shaOp = 3'd0;
						wordMemW = 1'b0;
						read_enable = 0;
					
					end
					
					AND: begin
						keyAssist = 0;
						encryption = 0;
						writeEnable = 1;
						aluSRC = 2'd0;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 1;
						execSrc = 2'd0; //ALU Unit
						wordSize = 7'd64;
						aluOp = 4'd4;
						maluOp = 4'bxxxx;
						shaOp = 3'd0;
						wordMemW = 1'b0;
						read_enable = 0;
					
					end
					
					sll: begin
						keyAssist = 0;
						encryption = 0;
						writeEnable = 1;
						aluSRC = 2'd0;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 1;
						execSrc = 2'd0; //ALU Unit
						wordSize = 7'd64;
						aluOp = 4'd5;
						maluOp = 4'bxxxx;
						shaOp = 3'd0;
						wordMemW = 1'b0;
						read_enable = 0;
					
					end
					
					srl: begin
						keyAssist = 0;
						encryption = 0;
						writeEnable = 1;
						aluSRC = 2'd0;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 1;
						execSrc = 2'd0; //ALU Unit
						wordSize = 7'd64;
						aluOp = 4'd6;
						maluOp = 4'bxxxx;
						shaOp = 3'd0;
						wordMemW = 1'b0;
						read_enable = 0;
					
					end
					
					ror: begin
						keyAssist = 0;
						encryption = 0;
						writeEnable = 1;
						aluSRC = 2'd0;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 1;
						execSrc = 2'd0; //ALU Unit
						wordSize = 7'd64;
						aluOp = 4'd7;
						maluOp = 4'bxxxx;
						shaOp = 3'd0;
						wordMemW = 1'b0;
						read_enable = 0;
					
					end
				
					
					rol: begin
						keyAssist = 0;
						encryption = 0;
						writeEnable = 1;
						aluSRC = 0;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 1;
						execSrc = 2'd0; //ALU Unit
						wordSize = 7'd64;
						aluOp = 4'd8;
						maluOp = 4'bxxxx;
						shaOp = 3'd0;
						wordMemW = 1'b0;
						read_enable = 0;
			
					end
					
				
				endcase
			end
			 //I-type instructions
			 I_TYPE: begin
				case(funct3)
					ADDI: begin
						keyAssist = 0;
						encryption = 0;
						writeEnable = 1;
						aluSRC = 2'd1;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 1;
						execSrc = 2'd0; //ALU Unit
						wordSize = 7'd64;
						aluOp = 4'd0;
						maluOp = 4'bxxxx;
						shaOp = 3'd0;
						wordMemW = 1'b0;
						read_enable = 0;
					
					end
					
					andi: begin
						keyAssist = 0;
						encryption = 0;
						writeEnable = 1;
						aluSRC = 2'd1;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 1;
						execSrc = 2'd0; //ALU Unit
						wordSize = 7'd64;
						aluOp = 4'd4;
						maluOp = 4'bxxxx;
						shaOp = 3'd0;
						wordMemW = 1'b0;
						read_enable = 0;				
					
					end
					
					slli: begin
						keyAssist = 0;
						encryption = 0;
						writeEnable = 1;
						aluSRC = 2'd1;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 1;
						execSrc = 2'd0; //ALU Unit
						wordSize = 7'd64;
						aluOp = 4'd5;
						maluOp = 4'bxxxx;
						read_enable = 0;
					
					end
					
					srli: begin
						keyAssist = 0;
						encryption = 0;
						writeEnable = 1;
						aluSRC = 2'd1;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 1;
						execSrc = 2'd0; //ALU Unit
						wordSize = 7'd64;
						aluOp = 4'd6;
						maluOp = 4'bxxxx;
						shaOp = 3'd0;
						wordMemW = 1'b0;
						read_enable = 0;
					
					end
					
					rori: begin
						keyAssist = 0;
						encryption = 0;
						writeEnable = 1;
						aluSRC = 2'd1;
						reg2Loc = 1;
						memWrite = 0;
						memOrExec = 1; //1 = Exec gets written
						finalRound = 1;
						execSrc = 2'd0; //ALU Unit
						wordSize = 7'd64;
						aluOp = 4'd7;
						maluOp = 4'bxxxx;
						shaOp = 3'd0;
						wordMemW = 1'b0;
						read_enable = 0;
					end
				
				endcase
	

			end
			
			 //Load-Type Instruction
			 LOAD: begin
				keyAssist = 0;
				encryption = 0;
				writeEnable = 1;
				aluSRC = 2'd1;
				reg2Loc = 0;
				memWrite = 0;
				memOrExec = 0; //1 = Exec gets written
				finalRound = 1;
				execSrc = 2'd0; //ALU Unit
				wordSize = 7'd64;
				aluOp = 4'd0;
				maluOp = 4'bxxxx;
				shaOp = 3'd0;
				wordMemW = 1'b0;
				read_enable = 1;
			
			 end
			
			
			 //Store-Type Instruction
			 STUR: begin
				keyAssist = 0;
				encryption = 0;
				writeEnable = 0;
				aluSRC = 2'd1;
				reg2Loc = 0;
				memWrite = 1;
				memOrExec = 0; //1 = Exec gets written
				finalRound = 1;
				execSrc = 2'd0; //ALU Unit
				wordSize = 7'd64;
				aluOp = 4'd0;
				maluOp = 4'bxxxx;
				shaOp = 3'd0;
				wordMemW = 1'b0;
				read_enable = 0;
			
			 end
			
		endcase
		
	end

endmodule
