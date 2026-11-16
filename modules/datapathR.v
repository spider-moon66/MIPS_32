module DTPR (
    input clk;
    input [31:0] Instruction,
);
    //Control wires
    wire CU_OUT;
    wire CU_RegWrite;
	wire CU_RegDst;
	wire CU_Branch;
	wire CU_MemWrite;
	wire CU_MemRead; 
	wire CU_MemToReg;
	wire [1:0] CU_ALUOp; 
	wire CU_ALUSrc;

    //reg wires

    //memgen wires
    wire [31:0] DataFM; //Data from mem

    //ALU_CTRL wires
    wire [3:0] AC_aluOP;

    //MIPSALU wires
    wire [31:0] ALU_RESULT;



    Control_Unit control(
        .op([31:26] Instruction), 
        .ALUOp(CU_ALUOp), 
        .RegWrite(CU_RegWrite), 
        .RegDst(CU_RegDst)
        .clk(clk);
    );

    ALU_CTRL aluCTRL(
        .Control_Signal(CU_ALUOp),
        .aluOP(AC_aluOP),
        .funct(),
        .clk(clk),
    );

    Registers reg(
        .clk(clk),
        .AR1(),
        .AR2(),
        .AW(),
        .DW(),
        .WE(),
        .DR1(),
        .DR2()
    );

    Memory_Data memgen(
        .clk(clk),
        .Address();
        .DataIn();
        .WtoM_enable(),
        .LfromM_enable(),
        .DataOut(DataFM)
    );

    MIPSALU alu_unit(
        .A(),
        .B(),
        .ALUctl(AC_aluOP),
        .ALUOut(ALU_RESULT)
    );


endmodule