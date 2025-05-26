module Ch(x, y, z, out);
	input logic [63:0] x, y, z;
	output logic [63:0] out;
	assign out = (x & y) ^ (~x & z);
endmodule
