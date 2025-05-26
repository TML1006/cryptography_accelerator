module keyExpansion(key, round, roundKey);
    input logic [127:0] key, round;
	 
	 output logic [127:0] roundKey;
	 
	logic [31:0] W0, W1, W2, W3;
    logic [31:0] rotWord, subWordOut;
    logic [31:0] Wl_4, Wl_5, Wl_6, Wl_7, Wl_temp;

    assign W0 = key[127:96];
    assign W1 = key[95:64];
    assign W2 = key[63:32];
    assign W3 = key[31:0];

    assign rotWord = (W3 >> 24) | (W3 << 8);

    subWord subWd(.W(rotWord), .subWordOut(subWordOut));
    rcon rcon_i(.in(subWordOut), .round(round[3:0]), .out(Wl_temp));

    assign Wl_4 = W0 ^ Wl_temp;
	 assign Wl_5 = W1 ^ Wl_4;
    assign Wl_6 = Wl_5 ^ W2;
    assign Wl_7 = Wl_6 ^ W3;

    assign roundKey = {Wl_4, Wl_5, Wl_6, Wl_7};
endmodule


module keyExp_testbench();
	logic [127:0] key, roundKey;
	logic [127:0] round;
	logic CLOCK_50;
	
	keyExpansion DUT(.key, .round, .roundKey);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	end
	
	initial begin
													  repeat(1) @(posedge CLOCK_50);
			   key <= 128'h2b7e151628aed2a6abf7158809cf4f3c; round <= 4'd0; repeat(1) @(posedge CLOCK_50);
																								 repeat(1) @(posedge CLOCK_50);
				
			$stop;
		end


endmodule
