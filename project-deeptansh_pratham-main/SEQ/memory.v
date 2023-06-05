`timescale 1ns / 10ps

module memory(
    input clk,
    input [3:0] icode,
    input [3:0] ifun,
    input [63:0] valA,
    input [63:0] valB,
    input [63:0] valE,
    input [63:0] valP,
    output reg [63:0] valF,
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

always @(*)
begin

    case(icode)

    RMMOVQ:
    begin
        mem[valE] = valA;
    end

    MRMOVQ:
    begin
        valF = mem[valE];
    end

    CALL:
    begin
        mem[valE] = valP;
    end

    RET:
    begin
        valF = mem[valA];
    end

    PUSHQ:
    begin
    mem[valE] = valA;
    end

    POPQ:
    begin
    valF = mem[valE];
    end

    endcase

    curr_mem = mem[valE];

end

endmodule

    

