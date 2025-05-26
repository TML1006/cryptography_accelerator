module wordMem(clk, reset, writeEnable, round, W_2_pre, W_7, W_15_pre, W_16, readWord, W_write);
	input logic [63:0] W_write;
	input logic [6:0] round;
	input logic clk, reset, writeEnable;
	
	output logic [63:0] W_2_pre, W_7, W_15_pre, W_16, readWord;
	
	integer i;
	logic [63:0] word_rom [0:79];

	// Sequential write
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin 
			for(i = 0; i < 80; i++) begin
				word_rom[i] <= 64'd0;
			end
		end
		else if (writeEnable) begin 
			word_rom[round] <= W_write;
		end
	end

	// Combinational reads
	assign readWord  = word_rom[round];
	assign W_2_pre   = (round >= 2)  ? word_rom[round - 2]  : 64'd0;
	assign W_7       = (round >= 7)  ? word_rom[round - 7]  : 64'd0;
	assign W_15_pre  = (round >= 15) ? word_rom[round - 15] : 64'd0;
	assign W_16      = (round >= 16) ? word_rom[round - 16] : 64'd0;

endmodule