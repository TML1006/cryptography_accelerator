module invShiftRows(in, out);
	input logic [7:0] in [3:0][3:0];
	output logic [7:0] out [3:0][3:0];
	
	// Row 0: no shift
	assign out[0][0] = in[0][0];
	assign out[0][1] = in[0][1];
	assign out[0][2] = in[0][2];
	assign out[0][3] = in[0][3];

	// Row 1: shift right by 1 → [d a b c]
	assign out[1][0] = in[1][3];
	assign out[1][1] = in[1][0];
	assign out[1][2] = in[1][1];
	assign out[1][3] = in[1][2];

	// Row 2: shift right by 2 → [c d a b]
	assign out[2][0] = in[2][2];
	assign out[2][1] = in[2][3];
	assign out[2][2] = in[2][0];
	assign out[2][3] = in[2][1];

	// Row 3: shift right by 3 → [b c d a]
	assign out[3][0] = in[3][1];
	assign out[3][1] = in[3][2];
	assign out[3][2] = in[3][3];
	assign out[3][3] = in[3][0];


endmodule

module invShiftRows_testbench();
	logic [7:0] in [3:0][3:0];
	logic [7:0] out [3:0][3:0];

	invShiftRows dut (.*);

	initial begin
		//Input: 7b 5b 54 65 73 74 56 65 63 74 6f 72 5d 53 47 5d
		in[0][0] = 8'he9; in[1][0] = 8'h31; in[2][0] = 8'h7d; in[3][0] = 8'hb5;
		in[0][1] = 8'hcb; in[1][1] = 8'h32; in[2][1] = 8'h2c; in[3][1] = 8'h72;
		in[0][2] = 8'h3d; in[1][2] = 8'h2e; in[2][2] = 8'h89; in[3][2] = 8'h5f;
		in[0][3] = 8'haf; in[1][3] = 8'h09; in[2][3] = 8'h07; in[3][3] = 8'h94;
		#10;
		$stop;
	end
endmodule 