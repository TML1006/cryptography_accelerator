module MALU(A, B, C, op, maluResult);
	input logic [127:0] A, B;
	input logic [5:0] C;
	input logic [2:0] op;
	
	output logic [127:0] maluResult;
	
	typedef enum logic [1:0]{
		mExp = 2'b00,
		mAdd = 2'b01,
		mMul = 2'b10,
		mod = 2'b11
	} maluOp_type;
	
	always_comb begin
		case(op)
			//Sneak in 3 operands by making RS2 longer and pulling some bits for mod number | Just make a 3 input operand instruction
			mExp: maluResult = (A**B) % C;
			mAdd: maluResult = (A+B) % C;
			mMul: maluResult = (A*B) % C;
			mod: maluResult = A % B;
			default: maluResult = '0;
		endcase
	end
endmodule
