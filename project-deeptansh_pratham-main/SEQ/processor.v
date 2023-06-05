`timescale 1ns / 10ps

`include "fetch.v"
`include "decode.v"
`include "execute.v"
`include "memory.v"
`include "pc_update.v"

module processor();

reg clk;
reg [63:0] PC;

wire [3:0]icode, ifun, rA, rB;

wire [64:1] valA, valB, valC, valP, valE, valF;

wire [63:0] rm0, rm1, rm2, rm3, rm4, rm5, rm6, rm7, rm8, rm9, rm10, rm11, rm12, rm13, rm14;

wire cnd, z, s, o;

wire [63:0] curr_mem;
wire [63:0] nPC;

fetch fetch_insta(
    .clk(clk),
    .PC(PC),
    .icode(icode),
    .ifun(ifun),
    .rA(rA),
    .rB(rB),
    .valC(valC),
    .valP(valP)
    );

decode decode_instb(
    .clk(clk),
    .cnd(cnd),
    .icode(icode),
    .ifun(ifun),
    .rA(rA),
    .rB(rB),
    .valE(valE),
    .valF(valF),
    .valA(valA),
    .valB(valB),
    .rm0(rm0),
    .rm1(rm1),
    .rm2(rm2),
    .rm3(rm3),
    .rm4(rm4),
    .rm5(rm5),
    .rm6(rm6),
    .rm7(rm7),
    .rm8(rm8),
    .rm9(rm9),
    .rm10(rm10),
    .rm11(rm11),
    .rm12(rm12),
    .rm13(rm13),
    .rm14(rm14)
);

execute execute_instc(
    .clk(clk),
    .icode(icode),
    .ifun(ifun),
    .valA(valA),
    .valB(valB),
    .valC(valC),
    .valE(valE),
    .cnd(cnd),
    .z(z),
    .s(s),
    .o(o)
);

// input clk,
// input [3:0] icode,
// input [3:0] ifun,
// input [63:0] valA,
// input [63:0] valB,
// input [63:0] valE,
// input [63:0] valP,
// output reg [63:0] valF,
// output reg [63:0] curr_mem

memory memory_instd(
    .clk(clk), 
    .icode(icode),
    .ifun(ifun), 
    .valA(valA), 
    .valB(valB), 
    .valE(valE), 
    .valP(valP),
    .valF(valF),
    .curr_mem(curr_mem)
);

// input clk,
// input cnd,
// input [3:0]icode,
// input [3:0]ifun,
// input [63:0]valC,
// input [63:0]valP,
// input [63:0]valF,
// input [63:0]PC,
// output reg [63:0]nPC

pc_update pc_update_inste(
    .clk(clk),
    .cnd(cnd),
    .icode(icode),
    .ifun(ifun),
    .valC(valC),
    .valP(valP),
    .valF(valF),
    .PC(PC),
    .nPC(nPC)
);

initial
begin
    $dumpfile("output.vcd");
    $dumpvars(0, processor);

    clk = 0;
    PC = 64'd0;

    #10 clk=~clk;
    #10 clk=~clk;
    PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;
    PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;
    PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;
    PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;
    PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;
    PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;
    PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;
    PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;
    PC=valP;

end

initial
begin
    $monitor ("clk = %d PC = %d nPC = %d icode = %d \n ifun = %d rA = %d rB = %d valC = %d \n valP = %d valE = %d valF = %d valA = %d \n valB = %d cnd = %d z = %d o = %d \n s = %d curr_mem = %d rm3 = %d rm2 = %d rm4 = %d \n\n",clk,PC,nPC,icode,ifun,rA,rB,valC,valP,valE,valF,valA,valB,cnd,z,o,s,curr_mem,rm3,rm2,rm4);
end

endmodule