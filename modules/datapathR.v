module DTPR (
    input clk,
    input [31:0] Instruction,
);

    wire [5:0]  opcode = Instruction[31:26];
    wire [4:0]  rs     = Instruction[25:21];
    wire [4:0]  rt     = Instruction[20:16];
    wire [4:0]  rd     = Instruction[15:11];
    wire [4:0]  shamt  = Instruction[10:6];
    wire [5:0]  funct  = Instruction[5:0];
    wire [15:0] imm    = Instruction[15:0];

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
        .op(opcode), 
        .ALUOp(CU_ALUOp), 
        .RegWrite(CU_RegWrite), 
        .RegDst(CU_RegDst)
    );

    ALU_CTRL aluCTRL(
        .Control_Signal(CU_ALUOp),
        .aluOP(AC_aluOP),
        .funct(funct),
        .clk(clk),
    );

    Registers reg(
        .clk(clk),
        .AR1(rs),
        .AR2(rt),
        .AW(rd),
        //Se conecta con la salida de un deplexor binario
        .DW(),
        .WE(CU_RegWrite),
        .DR1(),
        .DR2()
    );

    Memory_Data memgen(
        .clk(clk),
        .Address(),
        .DataIn(),
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