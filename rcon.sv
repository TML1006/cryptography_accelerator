module rcon(round, in, out);
	input logic [31:0] in;
	input logic [3:0] round;
	
	output logic [31:0] out;
	
	logic [31:0] rcon_j;
		
	logic [31:0] rcon_i [0:9] = '{32'h01000000, 32'h02000000, 32'h04000000, 32'h08000000, 32'h10000000,
											32'h20000000, 32'h40000000, 32'h80000000, 32'h1b000000, 32'h36000000};								
	assign rcon_j = rcon_i[round];
	
	assign out = in ^ rcon_j;
	

endmodule
