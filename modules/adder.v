module ADDER(
	input [31:0] PC,
	output [31:0] ADD_out,
	);
	
	assign ADD_out = PC + 32'd4;

endmodule
