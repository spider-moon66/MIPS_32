module Memory_Data( //memoria génerica de 32 bits
    input clk,
    input reset,
    input [4:0] Address,
    input [31:0] DataIN,
    input WtoM_enable, //escribir a memoria
    input LfromM_enable, //leer y cargar desde memoria
    output reg [31:0] DataOut
);

    reg [31:0]mem[0:31];

    always @(posedge clk) begin
        if(WtoM_enable == 1)begin
            mem[Address] <= DataIN;
        end
        if(LfromM_enable == 1)begin
            DataOut <= mem[Address];
        end
    end

    initial begin
        $readmemb("gen_mem.txt", mem);
    end

endmodule