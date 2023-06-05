`timescale 1ns/10ps
`include "fetch.v"

module decode_tb();

reg clk;
reg [63:0] PC;
reg [63:0] rm[0:14];

wire [3:0] icode;
wire [3:0] ifun;
wire [3:0] rA;
wire [3:0] rB; 
wire [63:0] valC;
wire [63:0] valP;
wire [63:0] valA;
wire [63:0] valB;
reg [63:0] valE;
reg [63:0] valF;

wire [63:0] rm0;
wire [63:0] rm1;
wire [63:0] rm2;
wire [63:0] rm3;
wire [63:0] rm4;
wire [63:0] rm5;
wire [63:0] rm6;
wire [63:0] rm7;
wire [63:0] rm8;
wire [63:0] rm9;
wire [63:0] rm10;
wire [63:0] rm11;
wire [63:0] rm12;
wire [63:0] rm13;
wire [63:0] rm14;

fetch fetch_uut (
    .clk(clk),
    .PC(PC),
    .icode(icode),
    .ifun(ifun),
    .rA(rA),
    .rB(rB),
    .valC(valC),
    .valP(valP)
);

decode decode_uut (
    .clk(clk),
    .icode(icode),
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

initial begin

clk = 0;
PC =64'd0;
valE = 64'd0;
valF = 64'd0;

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

initial begin
    $monitor("clk=%d PC=%d icode=%b ifun=%b rA=%d rB=%d,valC=%d,valP=%d valE=%d valF=%d valA=%d valB=%d rm3=%d \n",clk,PC,icode,ifun,rA,rB,valC,valP,valE,valF,valA,valB,rm3);
end

endmodule