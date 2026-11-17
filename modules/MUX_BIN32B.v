//mux binario de 32 bits I/O
module MUX_BIN_32B(
	input Control_Signal, 
	//Entradas genericas de 32 bits
	input [31:0] data0, //dataAlu
	input [31:0] data1, //dataMem
	output reg [31:0] dataOut
	);
	
	always @(*) begin
		//Solo uno de los dos puede llegar al puerto de entrada de escritura en el registro
		case (Control_Signal)
		//0, el bus de datos se toma de la salida de ALUMIPS
			1'b0 : begin
			  dataOut <= data0;
			end
		//1, el bus de datos se toma de la memoria generica
			1'b1 : begin
			  dataOut <= data1;
			end
		endcase
	end
endmodule