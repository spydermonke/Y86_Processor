`timescale 1ns / 10ps

module execute_tb;
    reg clk;
    reg [63:0] PC;
    reg [63:0] rm[0:14];
      
    wire cnd;
    wire [3:0] icode;
    wire [3:0] ifun;
    wire [3:0] rA;
    wire [3:0] rB; 
    wire [63:0] valA;
    wire [63:0] valB;
    wire signed [63:0] valE;
    wire [63:0] valC;
    wire [63:0] valP;
    wire [63:0] valF;


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


    // .valF(valF),
    // .rm0(rm0),
    // .rm1(rm1),
    // .rm2(rm2),
    // .rm3(rm3),
    // .rm4(rm4),
    // .rm5(rm5),
    // .rm6(rm6),
    // .rm7(rm7),
    // .rm8(rm8),
    // .rm9(rm9),
    // .rm10(rm10),
    // .rm11(rm11),
    // .rm12(rm12),
    // .rm13(rm13),
    // .rm14(rm14)




    fetch fetch_inst2(
    .clk(clk),
    .PC(PC),
    .icode(icode),
    .ifun(ifun),
    .rA(rA),
    .rB(rB),
    .valC(valC),
    .valP(valP)
    );

    decode decode_inst2(
    .clk(clk),
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

    execute execute(
    .clk(clk),
    .icode(icode),
    .ifun(ifun),
    .valA(valA),
    .valB(valB),
    .valC(valC),
    .valE(valE),
    .cnd(cnd)
    );

    initial begin
    rm[0] = 64'd0;
    rm[1] = 64'd1;
    rm[2] = 64'd2;
    rm[3] = 64'd3;
    rm[4] = 64'd4;
    rm[5] = 64'd5;
    rm[6] = 64'd6;
    rm[7] = 64'd7;
    rm[8] = 64'd8;
    rm[9] = 64'd9;
    rm[10] = 64'd10;
    rm[11] = 64'd11;
    rm[12] = 64'd12;
    rm[13] = 64'd13;
    rm[14] = 64'd14;

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

    end 
  
    initial begin
        $monitor("clk = %d PC=%d icode = %b ifun = %b rA = %b rB = %b valA = %d valB = %d valC=%d valE = %d cnd=%d rm4=%d\n",clk,PC,icode,ifun,rA,rB,valA,valB,valC,valE,cnd,rm4);
    end

endmodule