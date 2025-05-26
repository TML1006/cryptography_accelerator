/*
4/22/2025
shiftRows()
33 - 32 - 31 - 30
23 - 22 - 21 - 20
13 - 12 - 11 - 10
03 - 02 - 01 - 00
------------------
33 - 32 - 31 - 30  (unchanged)
22 - 21 - 20 - 23  (LS1)
11 - 10 - 13 - 12  (LS2)
00 - 03 - 02 - 01  (LS3)
*/

module shiftRows(in, out);
	input logic [7:0] in [3:0][3:0];
	output logic [7:0] out [3:0][3:0];
	 
	// row0: unchanged 
	assign out[0][3] = in[0][3];
	assign out[0][2] = in[0][2];
	assign out[0][1] = in[0][1];
	assign out[0][0] = in[0][0];

	// row1: shift left by 1
	assign out[1][3] = in[1][0]; // GOOD
	assign out[1][2] = in[1][3]; // GOOD
	assign out[1][1] = in[1][2]; // GOOD
	assign out[1][0] = in[1][1]; // GOOD

	// row2: shift left by 2 
	assign out[2][3] = in[2][1]; // GOOD
	assign out[2][2] = in[2][0]; // GOOD
	assign out[2][1] = in[2][3]; // GOOD
	assign out[2][0] = in[2][2]; // GOOD

	// row3: shift left by 3 
	assign out[3][3] = in[3][2];
	assign out[3][2] = in[3][1];
	assign out[3][1] = in[3][0];
	assign out[3][0] = in[3][3];
	
	
endmodule 

module shiftRows_testbench();
	logic [7:0] in [3:0][3:0];
	logic [7:0] out [3:0][3:0];

	shiftRows dut (.*);

	initial begin 
		in[0][0] = 8'h63; in[1][0] = 8'hC0; in[2][0] = 8'hAB; in[3][0] = 8'h20;
		in[0][1] = 8'hEB; in[1][1] = 8'h2F; in[2][1] = 8'h30; in[3][1] = 8'hCB;
		in[0][2] = 8'h9F; in[1][2] = 8'h93; in[2][2] = 8'hAF; in[3][2] = 8'h2B;
		in[0][3] = 8'hA0; in[1][3] = 8'h92; in[2][3] = 8'hC7; in[3][3] = 8'hA2;
		#10;
		$stop;
	end
endmodule 