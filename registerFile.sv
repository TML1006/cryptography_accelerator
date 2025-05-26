module registerFile(clk, reset, ReadReg1, ReadReg2, ReadReg3, WriteReg, WriteData, WriteEnable, ReadData1, ReadData2, ReadData3);
	input logic clk, reset;
	
	//Read Register Input Signals
	input logic [4:0] ReadReg1, ReadReg2, ReadReg3;
	
	
	//Write Register Signals
	input logic [127:0] WriteData;
	input logic [4:0] WriteReg;
	input logic WriteEnable;
	
	//Reading round key and state or some other thing. 
	output logic [127:0] ReadData1, ReadData2, ReadData3;
	
	logic [31:0][127:0] registers;
	
	//Reads
	always_comb begin
		ReadData1 = registers[ReadReg1];
		ReadData2 = registers[ReadReg2];
		ReadData3 = registers[ReadReg3];
	end
	
	integer i;
	always_ff @(posedge clk or reset) begin
		if(reset) begin
			for (i=0; i < 32; i++) begin
				registers[i] = 128'd0;
			end
		end
		else begin
			if(WriteEnable & WriteReg != 5'd31) registers[WriteReg] <= WriteData;
			else if(WriteReg == 5'd31) registers[WriteReg] <= 128'd0;
		end
	end
	
endmodule

module registerFile_testbench();
	logic clk, reset, WriteEnable;
	logic [127:0] WriteData, ReadData1, ReadData2;
	logic [4:0] ReadReg1, ReadReg2, WriteReg;
	logic [31:0][127:0] registers;
	
	
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	registerFile DUT(.*);
	
	initial begin
			reset <= 1;							  repeat(1) @(posedge clk);
			reset <= 0;							  repeat(1) @(posedge clk);
			ReadReg1 <= 5'd31; 
			ReadReg2 <= 5'd0; 
			WriteReg <= 5'd31; 
			WriteData <= 128'd31;
			WriteEnable <= 1;					  repeat(1) @(posedge clk);
			
			ReadReg1 <= 5'd31; 
			ReadReg2 <= 5'd31; 
			WriteReg <= 5'd0; 
			WriteData <= 128'd0;
			WriteEnable <= 0;					  repeat(1) @(posedge clk);
			
			ReadReg1 <= 5'd0; 
			ReadReg2 <= 5'd0; 
			WriteReg <= 5'd5; 
			WriteData <= 128'hABC;
			WriteEnable <= 1;					  repeat(1) @(posedge clk);
			
			
			ReadReg1 <= 5'd5; 
			ReadReg2 <= 5'd31; 
			WriteReg <= 5'd0; 
			WriteData <= 128'd0;
			WriteEnable <= 0;					  repeat(1) @(posedge clk);
			
			ReadReg1 <= 5'd30; 
			ReadReg2 <= 5'd5; 
			WriteReg <= 5'd30; 
			WriteData <= 128'hBEE;
			WriteEnable <= 1;					  repeat(1) @(posedge clk);
			
			ReadReg1 <= 5'd30; 
			ReadReg2 <= 5'd35; 
			WriteReg <= 5'd0; 
			WriteData <= 128'd0;
			WriteEnable <= 0;					  repeat(1) @(posedge clk);
			
			
			$stop;
		end
	

endmodule
