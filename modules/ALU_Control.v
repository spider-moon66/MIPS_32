module ALU_CTRL(
	input clk,
	input [5:0] funct,
	input [1:0] Control_Signal,
	output reg [3:0] aluOP);
	//Nota: se utilizan asignaciones no bloqueantes (<=) porque estamos intentando trabajar con un clk
	always @(posedge clk) begin
		case (Control_Signal)
		//siempre suma (lw/sw)
			2'b00 : begin
				
			end
		//siempre resta (beq)
			2'b01 : begin
				
			end
		//tipo R (consulta funct)
			2'b10: begin 
				case (funct)
				/*Nota: las operaciones de la alu se determinan de acuerdo al campo funct, 
				en esta implementación no hay una relación algebraica entre funct y aluOP, 
				es una convención educativa ampliamente documentada*/
					6'h20: aluOP <= 4'd2; //ADD
					6'h22: aluOP <= 4'd6; //SUB
					6'h24: aluOP <= 4'd0; //AND
					6'h25: aluOP <= 4'd1; //OR
					6'h2A: aluOP <= 4'd7; //SLT
					6'h27: aluOP <= 4'd12;//NOR
					default: aluOP <= 0;
				end
			end
		//Error
			default : begin
				aluOP <= 4'b111;
			end
		endcase
	end


endmodule