//MUX binario de 4 bits de entrada
module MUX_BIN_4B(
	input sel, 
	input [3:0] A, 
	input [3:0] B, 
	output reg [3:0] salida,
	output reg en);
	
	always @(*) begin
		case (sel)

	endcase
	end
endmodule