module programCounter(clk, reset, branchTaken, branchOffset, PC);
	input logic [63:0] branchOffset;
	input logic clk, reset, branchTaken;
	output logic [63:0] PC;
	
	always_ff @(posedge clk or reset) begin
		if(reset) PC <= 64'd0;
		else if(branchTaken) PC <= PC + ($signed(branchOffset) << 2);
		else PC <= PC + 4;
	end

endmodule
