module Control_Unit(
	input clk,
	input [5:0] op,
	//Nota: las salidas tienen que ser declaradas como registros para poder ser modificadas en el bloque always
	output reg RegWrite,
	output reg RegDst,//Determina cómo está especificado el registro de destino (rt o rd)
	output reg Branch,//Enabler, condición booleana para cargar la direccion del branch en PC
	output reg MemWrite,//Enabler, habilita la escritura en memoria
	output reg MemRead, //Enabler, activa la lectura de memoria
	output reg MemToReg, //Selecciona qué dato se escribe en el registro (ALU RESULTADO o memoria)
	//Dos bits: "00": Load/Store, "01": Branch, "10: R-TYPE", "11: Invalido/Indefinido", (ver documentación para un mejor desglose)
	output reg [1:0] ALUOp, //Especifica la operación de ALU o si la operación tiene que ser rescatada de los funct bits
	output reg ALUSrc //Selecciona el origen del segundo operando (rt o inmediato)
	);
	
	//decodificador de operaciones
	always@(posedge clk) begin
		case (op)
		//El código de operacion para instrucciones tipo R/SPECIAL es 0
		//Lo que distingue y agrupa diferentes tipos de instrucciones es el patrón de instrucción
			6'd0: begin
			RegDst = 1'b1;
			RegWrite = 1'b1;
			Branch = 1'b0;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b0;
			//Caracteristica de las instrucciones tipo R, la operación es determinada por el campo funct
			ALUOp = 2'b10;
			ALUSrc = 1'b0;
			end
			
			default: begin
			RegDst = 1'b0;
			RegWrite = 1'b0;
			Branch = 1'b0;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b0;
			ALUOp = 2'b00;
			ALUSrc = 1'b0;
			end
		endcase
	end
	
endmodule