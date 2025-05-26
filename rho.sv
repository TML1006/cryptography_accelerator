module rho(x, op, out);
	input logic [63:0] x;
	input logic op;
	output logic [63:0] out;
	logic [63:0] rot10, rot20, shr10, rot11, rot21, shr11;
	
	rotr rot0(.x(x), .rot(6'd1), .out(rot10));
	rotr rot0_1(.x(x), .rot(6'd8), .out(rot20));
	shr shr0(.x(x), .n(5'd7), .out(shr10));
	
	
	rotr rot1(.x(x), .rot(6'd19), .out(rot11)); 
	rotr rot1_1(.x(x), .rot(6'd61), .out(rot21)); 
	shr shr1(.x(x), .n(5'd6), .out(shr11));
	
	
	always_comb begin
		case(op)
			
			1'b0: out = rot10 ^ rot20 ^ shr10;
			
			1'b1: out = rot11 ^ rot21 ^ shr11;
			
			default: out = 64'd0;
		
		endcase
	
	end


endmodule