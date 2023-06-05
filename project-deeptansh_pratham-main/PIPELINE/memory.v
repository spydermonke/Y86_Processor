`timescale 1ns / 10ps

module memory(
    input clk,
    input [3:0] Micode,
    input [3:0] Mifun,
    input [63:0] MvalA,
    input [63:0] MvalE,
    input [3:0] MdstE,
    input [3:0] MdstM,
    output reg [63:0] mvalM,
    output reg [63:0] mvalE,
    output reg [3:0] mdstE,
    output reg [3:0] mdstM,
    output reg [3:0] micode,
    output reg [3:0] mifun,
    output reg [63:0] curr_mem
);

reg [63:0] mem[1023:0];

// FOR TESTING MEMORY USING RMMOVQ INSTRUCTION IN FETCH

initial begin
mem[203] = 64'd123;
end

//////////////////////////////

// DEFINING ICODE PARAMETERS

parameter HALT = 4'b0000;
parameter NOP = 4'b0001;
parameter CMOVXX = 4'b0010;
parameter IRMOVQ = 4'b0011;
parameter RMMOVQ = 4'b0100;
parameter MRMOVQ = 4'b0101;
parameter OPQ = 4'b0110;
parameter JXX = 4'b0111;
parameter CALL = 4'b1000;
parameter RET = 4'b1001;
parameter PUSHQ = 4'b1010;
parameter POPQ = 4'b1011;

always @(posedge clk)
begin

    case(Micode)

    RMMOVQ:
    begin
        mem[MvalE] = MvalA;
    end

    MRMOVQ:
    begin
        mvalM = mem[MvalE];
    end

    CALL:
    begin
        mem[MvalE] = MvalA;
    end

    RET:
    begin
        mvalM = mem[MvalA];
    end

    PUSHQ:
    begin
    mem[MvalE] = MvalA;
    end

    POPQ:
    begin
    mvalM = mem[MvalA];
    end

    endcase

    curr_mem = mem[MvalE]; // To keep a track of the last fed element into and from the memory

end

always@(*)
begin
    micode = Micode;
    mifun = Mifun;
    mdstM = MdstM;
    mvalE = MvalE;
    mdstE = MdstE;
end

endmodule

    

