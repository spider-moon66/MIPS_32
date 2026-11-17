`timescale 1ns/1ns

module DTPR_TB;

reg clk;
    reg [31:0] Instruction;

    DTPR datapathR_dut(
        .clk(clk),
        .Instruction(Instruction)
    );

    // Generador de reloj 10ns
    initial begin
        clk = 0;
    end

    always #5 clk = ~clk;

    // Estímulos
    initial begin

        Instruction = 32'b0;

        #10;
        Instruction = 32'b000000_00001_00010_00011_00000_100000;

        #10;
        Instruction = 32'b000000_00010_00011_00100_00000_100010;

        #20;
        $finish;

    end

endmodule
