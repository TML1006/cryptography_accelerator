module Maj(x, y, z, out);
	input logic [63:0] x, y, z;
	output logic [63:0] out;
	assign out = (x & y) ^ (x & z) ^ (y & z);
endmodule


module Maj_testbench ();
	logic [63:0] x, y, z, out;
	logic clk;

	Maj DUT(.*);

	parameter CLOCK_PERIOD = 2;
	initial begin
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  // forever toggle the clock
	end

	initial begin
		x = 64'h22312194FC2BF72C;
		y = 64'h9F555FA3C84C64C2;
		z = 64'h2393B86B6F53B151;
		repeat(3) @(posedge clk);
		$stop;
	end


endmodule