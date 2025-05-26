module shr(x, n, out);
	input logic [63:0] x;
	input logic [4:0] n;
	output logic [63:0] out;
	assign out = x >> n;
endmodule
