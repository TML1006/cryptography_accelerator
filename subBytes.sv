/*
5/9/2025
subBytes module 

1. multiplicative inverse x' = x^-1 = x^254  
2. XOR x' with right shift 4, 5, 6, 7, of x' and 0x63 

*/

module subBytes(in, out);
	input logic [7:0] in [3:0][3:0];
   output logic [7:0] out [3:0][3:0];

	//logic [7:0] inv [3:0][3:0]; // inverse 

//	logic [7:0] inv_rs4 [3:0][3:0]; // right shift 4
//	logic [7:0] inv_rs5 [3:0][3:0]; // right shift 5
//	logic [7:0] inv_rs6 [3:0][3:0]; // right shift 6
//	logic [7:0] inv_rs7 [3:0][3:0]; // right shift 7
//	
//	logic [7:0] C = 8'h63;

	// -------- 1. TODO: inverse logic ----------
	/*integer i, j;
	always_comb begin 
		for (i = 0; i < 4; i++) begin
			for(j = 0; j < 4; j++) begin
				inv[i][j] = (in[i][j] == 0) ? (8'h00) : (in[i][j] ** 254);
			end
		
		
		end
	end
	
	
	// -------- 2. XOR stage --------------------
	assign inv_rs4 = inv >> 4;
	assign inv_rs5 = inv >> 5;
	assign inv_rs6 = inv >> 6;
	assign inv_rs7 = inv >> 7;

	// output logic 
	assign out = inv ^ inv_rs4 ^ inv_rs5 ^ inv_rs6 ^ inv_rs7 ^ C; */
	
	sboxSb subB(.*);
endmodule 

module subBytes_testbench();
	logic [7:0] in [3:0][3:0];
   logic [7:0] out [3:0][3:0];
	
	subBytes DUT(.*);
	
	initial begin
		// Column-major order: in[row][col]
		in[0][0] = 8'h00; in[1][0] = 8'h1F; in[2][0] = 8'h0E; in[3][0] = 8'h54;
		in[0][1] = 8'h3C; in[1][1] = 8'h4E; in[2][1] = 8'h08; in[3][1] = 8'h59;
		in[0][2] = 8'h6E; in[1][2] = 8'h22; in[2][2] = 8'h1B; in[3][2] = 8'h0B;
		in[0][3] = 8'h47; in[1][3] = 8'h74; in[2][3] = 8'h31; in[3][3] = 8'h1A;

		#10;
	
		$stop;
	end

endmodule
