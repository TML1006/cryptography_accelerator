module mixColumns_col(col_i, col_o);
    input logic [7:0] col_i [3:0];
    output logic [7:0] col_o [3:0];

    logic [7:0] in_times2 [3:0];
    logic [7:0] in_times3 [3:0];

    // intermediate times2 and times3 values 
    genvar i;
    generate 
        for (i = 0; i < 4; i++) begin 
            xTimes2 times2_instance (.b_i(col_i[i]), .b_o(in_times2[i]));
            xTimes3 times3_instance (.b_i(col_i[i]), .b_o(in_times3[i]));
        end 
    endgenerate
	 
	 //Assign Output
	 assign col_o[0] = in_times2[0] ^ in_times3[1] ^ col_i[2] ^ col_i[3];
    assign col_o[1] = col_i[0] ^ in_times2[1] ^ in_times3[2] ^ col_i[3];
    assign col_o[2] = col_i[0] ^ col_i[1] ^ in_times2[2] ^ in_times3[3];
    assign col_o[3] = in_times3[0] ^ col_i[1] ^ col_i[2] ^ in_times2[3];
	 
endmodule 

module invMixColumns_col(col_i, col_o);
	input logic [7:0] col_i [3:0];
   output logic [7:0] col_o [3:0];

	logic [7:0] in_timesE [3:0];
	logic [7:0] in_times9 [3:0];
	logic [7:0] in_timesD [3:0];
	logic [7:0] in_timesB [3:0];

	// intermediate times2 and times3 values 
	genvar i;
	generate 
    for (i = 0; i < 4; i++) begin : xtimes_instances
        xTimese timesE_instance (.b_i(col_i[i]), .b_o(in_timesE[i]));
        xTimes9 times9_instance (.b_i(col_i[i]), .b_o(in_times9[i]));
        xTimesd timesD_instance (.b_i(col_i[i]), .b_o(in_timesD[i]));
        xTimesb timesB_instance (.b_i(col_i[i]), .b_o(in_timesB[i]));
    end 
	endgenerate

	 
	//Assign Output
	assign col_o[0] = in_timesE[0] ^ in_timesB[1] ^ in_timesD[2] ^ in_times9[3];
	assign col_o[1] = in_times9[0] ^ in_timesE[1] ^ in_timesB[2] ^ in_timesD[3];
	assign col_o[2] = in_timesD[0] ^ in_times9[1] ^ in_timesE[2] ^ in_timesB[3];
	assign col_o[3] = in_timesB[0] ^ in_timesD[1] ^ in_times9[2] ^ in_timesE[3];

endmodule

module xTimes2(b_i, b_o);
    input logic [7:0] b_i;
    output logic [7:0] b_o;

    logic [7:0] b_shifted;

    // left shift 1 logic 
    assign b_shifted = b_i << 1;

    // MSB check & output logic 
    assign b_o = b_i[7] ? (b_shifted ^ 8'h1B) : b_shifted;


endmodule 

module xTimes3(b_i, b_o);
    input logic [7:0] b_i;
    output logic [7:0] b_o;
    
    logic [7:0] b_times2;

    xTimes2 times2 (.b_i(b_i), .b_o(b_times2));

    assign b_o = b_times2 ^ b_i;
endmodule 


module xTimese(b_i, b_o); //e -> 14 = 2 * (2 * (2 * b)) + b * 2
    input logic [7:0] b_i;
    output logic [7:0] b_o;

    logic [7:0] xt2, xt4, xt8, temp;

    xTimes2 u1(.b_i(b_i), .b_o(xt2));      // b×2
    xTimes2 u2(.b_i(xt2), .b_o(xt4));      // b×4
    xTimes2 u3(.b_i(xt4), .b_o(xt8));      // b×8

    assign b_o = xt8 ^ xt4 ^ xt2;         // b×8 ^ b×4 ^ b×2 = b×14
endmodule

module xTimese_testbench();
	logic [7:0] b_i;
   logic [7:0] b_o;
	
	xTimese xE(.*);
	
	initial begin
		b_i = 8'h37; //Produce 11
		#5;
		b_i = 8'h94; //Produce 99
		#5;
		b_i = 8'hED; //Produces 71
		#5;
	
		$stop;
	end

endmodule

module xTimes9(b_i, b_o); // 9 = 8 + 1
    input logic [7:0] b_i;
    output logic [7:0] b_o;

    logic [7:0] xt2, xt4, xt8;

    xTimes2 u1(.b_i(b_i), .b_o(xt2));
    xTimes2 u2(.b_i(xt2), .b_o(xt4));
    xTimes2 u3(.b_i(xt4), .b_o(xt8));

    assign b_o = xt8 ^ b_i;  // b×8 ^ b = b×9
	 
endmodule

module xTimes9_testbench();
	logic [7:0] b_i;
   logic [7:0] b_o;
	
	xTimes9 x9(.*);
	
	initial begin
		b_i = 8'h37;
		#5;
		b_i = 8'h47;
		#5;
		b_i = 8'hA5;
		#5;
	
		$stop;
	end

endmodule

module xTimesd(b_i, b_o); // 13 = 8 + 4 + 1
    input logic [7:0] b_i;
    output logic [7:0] b_o;

    logic [7:0] xt2, xt4, xt8;

    xTimes2 u1(.b_i(b_i), .b_o(xt2));
    xTimes2 u2(.b_i(xt2), .b_o(xt4));
    xTimes2 u3(.b_i(xt4), .b_o(xt8));

    assign b_o = xt8 ^ xt4 ^ b_i;
endmodule

module xTimesb(b_i, b_o); // 11 = 8 + 2 + 1
    input logic [7:0] b_i;
    output logic [7:0] b_o;

    logic [7:0] xt2, xt4, xt8;

    xTimes2 u1(.b_i(b_i), .b_o(xt2));
    xTimes2 u2(.b_i(xt2), .b_o(xt4));
    xTimes2 u3(.b_i(xt4), .b_o(xt8));

    assign b_o = xt8 ^ xt2 ^ b_i;
endmodule

module xTimesd_testbench();
	logic [7:0] b_i;
   logic [7:0] b_o;
	
	xTimesd xD(.*);
	
	initial begin
		b_i = 8'h47; //Produce 4E
		#5;
		b_i = 8'h37; //Produce 48
		#5;
		b_i = 8'hE4; //Produce 38
		#5;
	
		$stop;
	end

endmodule

module xTimesb_testbench();
	logic [7:0] b_i;
   logic [7:0] b_o;
	
	xTimesb xB(.*);
	
	initial begin
		b_i = 8'hED; //Produce 05
		#5;
		b_i = 8'h47; //Produce C7
		#5;
		b_i = 8'hD4; //Produce 9D
		#5;
	
		$stop;
	end

endmodule

// module xTimes2_tb();
//     logic [7:0] b_i, b_o;

//     xTimes dut (.b_i, .b_o);

//     initial begin 
//         b_i <= 8'b10001000; #10;
//         b_i <= 8'b00010001; #10;
//         b_i <= 8'b11110001; #10;
//         $stop;
//     end
// endmodule 

module mixColumns_col_testbench();
    logic [7:0] col_i [3:0];
    logic [7:0] col_o [3:0];

    mixColumns_col dut (.col_i, .col_o);

    initial begin 
        col_i[0] = 8'h63;
        col_i[1] = 8'h2F;
        col_i[2] = 8'hAF;
        col_i[3] = 8'hA2;
        #10;
        col_i[0] = 8'hEB;
        col_i[1] = 8'h93;
        col_i[2] = 8'hC7;
        col_i[3] = 8'h20;
        #10;
        $stop;
    end
endmodule 


module invMixColumns_col_testbench();
    logic [7:0] col_i [3:0];
    logic [7:0] col_o [3:0];

    invMixColumns_col dut (.col_i, .col_o);

    initial begin 
      col_i[0] = 8'heb ^ 8'hac;
		col_i[1] = 8'h40 ^ 8'h77;
		col_i[2] = 8'hf2 ^ 8'h66;
		col_i[3] = 8'h1e ^ 8'hf3;
		#10;

		col_i[0] = 8'h59 ^ 8'h19;
		col_i[1] = 8'h2e ^ 8'hfa;
		col_i[2] = 8'h38 ^ 8'hdc;
		col_i[3] = 8'h84 ^ 8'h21;
		#10;
		col_i[0] = 8'h8b ^ 8'h28;
		col_i[1] = 8'ha1 ^ 8'hd1;
		col_i[2] = 8'h13 ^ 8'h29;
		col_i[3] = 8'he7 ^ 8'h41;
		#10;

		col_i[0] = 8'h1b ^ 8'h57;
		col_i[1] = 8'hc3 ^ 8'h5c;
		col_i[2] = 8'h42 ^ 8'h00;
		col_i[3] = 8'hd2 ^ 8'h6e;
		#10;

        $stop;
    end
endmodule 