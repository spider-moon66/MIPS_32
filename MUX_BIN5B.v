//mux binario de 5 bits I/O
module MUX_BIN_5B(
	input Control_Signal, 
	//Entradas genericas de 5 bits
	input [4:0] data0, //dataAlu
	input [4:0] data1, //dataMem
	output reg [4:0] dataOut
	);
	
	always @(*) begin
		//Solo uno de los dos puede llegar al puerto de entrada de escritura en el registro
		case (Control_Signal)
		//0, la direccion de escritura se toma del campo rt
			1'b0 : begin
			  dataOut <= data0;
			end
		//1, la direccion de escritura se toma del campo rd
			1'b1 : begin
			  dataOut <= data1;
			end
		endcase
	end
endmodule