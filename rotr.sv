module rotr(x, rot, out);
	input logic [63:0] x;
	input logic [5:0] rot;
	output logic [63:0] out;
	assign out = (x >> rot) | (x << (64-rot));
endmodule