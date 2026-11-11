
module Instruction_Memory(
	input clk;
	input [4:0] AR,//read address
	output reg [31:0] DR //Instruction
	);
	
	reg [31:0]mem[0:31];
	
	always @(posedge clk) begin
		DR = mem[AR];
	end
	
	initial begin
		$readmemb("instruction_memory.txt", mem);
	end
	
endmodule
