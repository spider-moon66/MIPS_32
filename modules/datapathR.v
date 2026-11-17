module DTPR (
    input clk,
    input [31:0] Instruction
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

    //mux reg wires
    wire [31:0] MUX_REG_OUT;

    //reg wires
    wire [31:0] A_R;
    wire [31:0] B_R;

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
        .clk(clk)
    );

    MUX_BIN_32B mux_reg(
        .Control_Signal(CU_MemToReg),
        .data0(ALU_RESULT),
        .data1(DataFM),
        .dataOut(MUX_REG_OUT)
    );

    Registers GP_reg(
        .clk(clk),
        .AR1(rs),
        .AR2(rt),
        //En un full datapath, esta entrada se coneccta con la salida de un mux binario
        .AW(rd),
        //Se conecta con la salida de un mux binario
        .DW(MUX_REG_OUT),
        .WE(CU_RegWrite),
        .DR1(A_R),
        .DR2(B_R)
    );

    Memory_Data memgen(
        .clk(clk),
        .Address(),
        .DataIn(),
        .WtoM_enable(CU_MemWrite),
        .LfromM_enable(CU_MemRead),
        .DataOut(DataFM)
    );

    MIPSALU alu_unit(
        .A(A_R),
        .B(B_R),
        .ALUctl(AC_aluOP),
        .ALUOut(ALU_RESULT)
    );


endmodule