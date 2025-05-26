module sigma(x, op, out);
	input logic [63:0] x;
	input logic op;
	output logic [63:0] out;
	logic [63:0] rot00, rot01, rot02, rot10, rot11, rot12;
	
	rotr rot0(.x(x), .rot(6'd28), .out(rot00));
	rotr rot0_1(.x(x), .rot(6'd34), .out(rot01));
	rotr rot0_2(.x(x), .rot(6'd39), .out(rot02));
	

	rotr rot1(.x(x), .rot(6'd14), .out(rot10)); 
	rotr rot1_1(.x(x), .rot(6'd18), .out(rot11)); 
	rotr rot1_2(.x(x), .rot(6'd41), .out(rot12));
	
	always_comb begin
		case(op) 
			1'b0: out = (rot00 ^ rot01) ^ rot02;
			
			1'b1: out = rot10 ^ rot11 ^ rot12;
			
			default: out = 64'd0;
		
		endcase
	end

endmodule

module sigma_testbench();
	logic [63:0] x, out;
	logic op, clk;

	sigma DUT(.*);

	parameter CLOCK_PERIOD = 2;
	initial begin
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  // forever toggle the clock
	end

	initial begin
		x = 64'h22312194FC2BF72C;
		op = 0;
		repeat(3) @(posedge clk);
		$stop;
	end


endmodule