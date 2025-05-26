module shaUnit(clk, reset, A, B, C, shaOp, set_type, wordMemW, hashResult);
	input logic [127:0] A, B, C;
	input logic [2:0] shaOp;
	input logic [1:0] set_type;
	input logic clk, reset, wordMemW; 

	output logic [127:0] hashResult; 

	logic [127:0] outHash, newHashes, outFinal;
	logic [63:0] W_t, Wt_2, Wt_7, Wt_15, Wt_16, W2, W15, T1, T2, sig1, sig0, ch1, maj1, Kt, Wt, W_write;

	typedef enum logic [2:0] {
		OP_WT = 3'd0,
		OP_T1 = 3'd1,
		OP_T2 = 3'd2,
		OP_COM = 3'd3,
		OP_INIT = 3'd4,
		OP_FINAL = 3'd5
	} operation;
	
	wordConst wordCon(.round(C[6:0]), .Kt(Kt));

	wordMem word_mem(.clk, .reset, .W_2_pre(Wt_2), .W_7(Wt_7), .W_15_pre(Wt_15), .W_16(Wt_16), .round(C[6:0]), .W_write, .writeEnable(wordMemW), .readWord(Wt));

	//Calculate W_t
	rho rho1(.x(Wt_2), .op(1'b1), .out(W2));
	rho rho0(.x(Wt_15), .op(1'b0), .out(W15));
	assign W_t = (W2 + Wt_7 + W15 + Wt_16);
	assign W_write = (C[6:0] < 16) ? A[63:0] : W_t;

	//Calculate T1
	//A[127:64] = e || A[63:0] = f || B[127:64] = g || B[63:0] = h
	sigma sigma1(.x(A[127:64]), .op(1'b1), .out(sig1));
	Ch ch_1(.x(A[127:64]), .y(A[63:0]), .z(B[127:64]), .out(ch1));
	assign T1 = (B[63:0] + sig1 + ch1 + Kt + Wt);

	//Calculate T2
	//A[127:64] = a || A[63:0] = b || B[127:64] = c || B[63:0] = d
	sigma sigma0(.x(A[127:64]), .op(1'b0), .out(sig0));
	Maj maj_1(.x(A[127:64]), .y(A[63:0]), .z(B[127:64]), .out(maj1));
	assign T2 = (sig0 + maj1);

	//Set new Hashes
	setHashes set_hash(.A, .B, .C, .set_type, .newHashes);

	//Finalize Hash
	finalHash final_hash(.A, .set_type, .outFinal);

	//Calculate initHash
	initHash init_hash(.t(C[1:0]), .outHash(outHash));


	always_comb begin
		case(shaOp)
			OP_WT: hashResult = {64'd0, W_write};

			OP_T1: hashResult = {64'd0, T1};

			OP_T2: hashResult = {64'd0, T2};

			OP_COM: hashResult = newHashes;

			OP_INIT: hashResult = outHash;

			OP_FINAL: hashResult = outFinal;

			default: hashResult = 128'd0;

		endcase
	end
	
endmodule

module shaUnit_testbench();
	logic [127:0] A, B, hashResult;
	logic [6:0] t;
	logic [1:0] shaOp;
	logic clk, reset, wordMemW;

	shaUnit sha_unit(.*);

	parameter CLOCK_PERIOD = 2;
	initial begin
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  // forever toggle the clock
	end
	
	// test
	initial begin
		reset <= 1;			@(posedge clk);
		reset <= 0;			@(posedge clk);
		
		//Check initHash
		A <= '0;
		B <= '0;
		t <= 7'd0;
		shaOp <= 2'd4;
		wordMemW <= 1'b0;  @(posedge clk);
		A <= '0;
		B <= '0;
		t <= 7'd2;
		shaOp <= 2'd3;
		wordMemW <= 1'b0;  @(posedge clk);
		A <= '0;
		B <= '0;
		t <= 7'd4;
		shaOp <= 2'd3;
		wordMemW <= 1'b0;  @(posedge clk);
		A <= '0;
		B <= '0;
		t <= 7'd6;
		shaOp <= 2'd3;
		wordMemW <= 1'b0;  @(posedge clk);

		A <= 128'h0000000000000000_6162638000000000;
		B <= 128'h2393B86B6F53B151_963877195940EABD;
		t <= 7'd0;
		shaOp <= 2'd0;
		wordMemW <= 1'b1;  @(posedge clk);

		A <= 128'h22312194FC2BF72C_9F555FA3C84C64C2;
		B <= 128'h2393B86B6F53B151_963877195940EABD;
		t <= 7'd0;
		shaOp <= 2'd2;
		wordMemW <= 1'b0;  @(posedge clk);

		A <= 128'h96283EE2A88EFFE3_BE5E1E2553863992;
		B <= 128'h2B0199FC2C85B8AA_0EB72DDC81C52CA2;
		t <= 7'd0;
		shaOp <= 2'd1;
		wordMemW <= 1'b0;  @(posedge clk);



		$stop;
	end

endmodule
