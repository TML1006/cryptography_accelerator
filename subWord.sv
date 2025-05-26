module subWord(W, subWordOut);
	input logic [31:0] W;
	output logic [31:0] subWordOut;
	
	logic [7:0] byte3, byte2, byte1, byte0;
	logic [7:0] s3, s2, s1, s0;
	
	assign byte3 = W[31:24];
	assign byte2 = W[23:16];
	assign byte1 = W[15:8];
	assign byte0 = W[7:0];

	Sbox sub(.byte3, .byte2, .byte1, .byte0, .s3, .s2, .s1, .s0);
	
	assign subWordOut = {s3, s2, s1, s0};

endmodule

module subword_testbench();
	logic [31:0] W, subWordOut;
	logic clk;
	
	subWord DUT(.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	initial begin
		W <= 31'h59f67f73; repeat(1) @(posedge clk); //Expected output: cb42d28f
		
		W <= 31'h7a883b6d; repeat(1) @(posedge clk); //Expected output: dac4e23c
		$stop;
	end

endmodule
