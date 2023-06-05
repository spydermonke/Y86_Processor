`timescale 1ns / 10ps

`include "fetch.v"
`include "decode.v"
`include "execute.v"
`include "memory.v"
//`include "write_back.v"
`include "pc_update.v"
`include "logic1.v"
`include "reg_file.v"

// ALL THE COMMENTED DECLARATIONS AND MODULES ARE TO WRITE THE INSTANT OF MODULE EASILY BY REFERING TO THEM

module procpipe();

reg clk;

// module fetch(
//     clk, 
//     ficode, 
//     fifun, 
//     frA, 
//     frB, 
//     fvalC, 
//     fvalP, 
//     halt, 
//     prPC, 
//     fPC
// );

wire [3:0] ficode;
wire [3:0] fifun;
wire [3:0] frA;
wire [3:0] frB;

wire [63:0] fvalC;
wire [63:0] fvalP;
wire [63:0] prPC;
reg [63:0] fPC;

fetch fuut(.clk(clk), .ficode(ficode), .fifun(fifun), .frA(frA), .frB(frB), .fvalC(fvalC), .fvalP(fvalP), .halt(halt), .prPC(prPC), .fPC(fPC));


// module decode(
//     input clk,
//     input cnd,
//     input [3:0] DrA,
//     input [3:0] DrB,
//     input [63:0] DvalC,
//     input [63:0] DvalP,
//     input [3:0] Dicode,
//     input [3:0] Difun,

//     input [3:0] edstE,
//     input [3:0] edstM,
//     input [3:0] MdstE,
//     input [3:0] MdstM,
//     input [3:0] WdstE,
//     input [3:0] WdstM,

//     input [63:0] evalE,
//     input [63:0] MvalE,
//     input [63:0] mvalM,
//     input [63:0] WvalM,
//     input [63:0] WvalE,
    
//     output reg [63:0] rvalA,
//     output reg [63:0] rvalB,

//     output reg [63:0] rm0,
//     output reg [63:0] rm1,
//     output reg [63:0] rm2,
//     output reg [63:0] rm3,
//     output reg [63:0] rm4,
//     output reg [63:0] rm5,
//     output reg [63:0] rm6,
//     output reg [63:0] rm7,
//     output reg [63:0] rm8,
//     output reg [63:0] rm9,
//     output reg [63:0] rm10,
//     output reg [63:0] rm11,
//     output reg [63:0] rm12,
//     output reg [63:0] rm13,
//     output reg [63:0] rm14,

//     output reg [63:0] dvalA,
//     output reg [63:0] dvalB,
//     output reg [63:0] dvalC,
//     output reg [63:0] ddstE,
//     output reg [63:0] ddstM,
//     output reg [63:0] dsrcA,
//     output reg [63:0] dsrcB,
//     output reg [63:0] dicode,
//     output reg [63:0] difun
// );

wire cnd;
wire [3:0] DrA;
wire [3:0] DrB;
wire [3:0] Dicode;
wire [3:0] Difun;

wire [3:0] edstE;
wire [3:0] edstM;
wire [3:0] MdstE;
wire [3:0] MdstM;

wire [3:0] WdstE;
wire [3:0] WdstM;

wire [63:0] evalE;
wire [63:0] MvalE;
wire [63:0] mvalM;
wire [63:0] WvalM;
wire [63:0] WvalE;

wire [63:0] rvalA;
wire [63:0] rvalB;

wire [63:0] DvalC;
wire [63:0] DvalP;

wire [63:0] dvalA;
wire [63:0] dvalB;
wire [63:0] dvalC;

wire [3:0] ddstE; 
wire [3:0] ddstM; 
wire [3:0] dsrcA; 
wire [3:0] dsrcB; 
wire [3:0] dicode; 
wire [3:0] difun;


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

wire [3:0] Wicode;
wire [3:0] Wifun;
wire Wcnd;

decode duut(.clk(clk), .cnd(cnd), .DrA(DrA), .DrB(DrB), .DvalC(DvalC), .DvalP(DvalP), .Dicode(Dicode), .Difun(Difun), .edstE(edstE), .edstM(edstM), .MdstE(MdstE), .MdstM(MdstM), .WdstE(WdstE), .WdstM(WdstM), .evalE(evalE), .MvalE(MvalE), .mvalM(mvalM), .WvalM(WvalM), .WvalE(WvalE), .rvalA(rvalA), .rvalB(rvalB), .rm0(rm0), .rm1(rm1), .rm2(rm2), .rm3(rm3), .rm4(rm4), .rm5(rm5), .rm6(rm6), .rm7(rm7), .rm8(rm8), .rm9(rm9), .rm10(rm10), .rm11(rm11), .rm12(rm12), .rm13(rm13), .rm14(rm14), .dvalA(dvalA), .dvalB(dvalB), .dvalC(dvalC), .ddstE(ddstE), .ddstM(ddstM), .dsrcA(dsrcA), .dsrcB(dsrcB), .dicode(dicode), .difun(difun), .Wicode(Wicode), .Wifun(Wifun), .Wcnd(Wcnd));
// input [3:0] Wicode,
//     input [3:0] Wifun,
//     input Wcnd

// module execute(
//     input clk,
//     input [3:0]Eicode,
//     input [3:0]Eifun,
//     input [3:0]EdstE,
//     input [3:0]EdstM,
//     input [63:0]EvalA,
//     input [63:0]EvalB,
//     input [63:0]EvalC,

//     output reg signed [63:0] evalE,
//     output reg signed [63:0] evalA,
//     output reg [3:0] edstE,
//     output reg [3:0] eicode,
//     output reg [3:0] eifun,
//     output reg [3:0] edstM,

//     output reg ecnd,
//     output reg z,
//     output reg s,
//     output reg o
// );

wire [3:0] Eicode;
wire [3:0] Eifun;
wire [3:0] EdstE;
wire [3:0] EdstM;

wire [63:0] EvalA;
wire [63:0] EvalB;
wire [63:0] EvalC;


wire [63:0] evalA;



wire [3:0] eicode;
wire [3:0] eifun;

wire ecnd;
wire z;
wire s;
wire o;


execute euut(.clk(clk), .Eicode(Eicode), .Eifun(Eifun), .EdstE(EdstE), .EdstM(EdstM), .EvalA(EvalA), .EvalB(EvalB), .EvalC(EvalC), .evalE(evalE), .evalA(evalA), .edstE(edstE), .eicode(eicode), .eifun(eifun), .edstM(edstM), .ecnd(ecnd), .z(z), .s(s), .o(o));


// module memory(
//     input clk,
//     input [3:0] Micode,
//     input [3:0] Mifun,
//     input [63:0] MvalA,
//     input [63:0] MvalE,
//     input [3:0] MdstE,
//     input [3:0] MdstM,
//     output reg [63:0] mvalM,
//     output reg [63:0] mvalE,
//     output reg [3:0] mdstE,
//     output reg [3:0] mdstM,
//     output reg [3:0] micode,
//     output reg [63:0] curr_mem
// );

wire [3:0] Micode;
wire [3:0] Mifun;
wire [63:0] MvalA;
// wire [63:0] MvalE;
// wire [3:0] MdstE;
// wire [3:0] MdstM;
wire [63:0] mvalE;
// wire [63:0] mvalM;
wire [3:0] mdstE;
wire [3:0] mdstM;
wire [3:0] micode;
wire [3:0] mifun;
wire [63:0] curr_mem;

memory muut(.clk(clk), .Micode(Micode), .Mifun(Mifun), .MvalA(MvalA), .MvalE(MvalE), .MdstE(MdstE), .MdstM(MdstM), .mvalM(mvalM), .mvalE(mvalE), .mdstE(mdstE), .mdstM(mdstM), .micode(micode), .mifun(mifun), .curr_mem(curr_mem));


// module wb(
//     input clk,
//     input [3:0] Wicode,
//     input [3:0] Wifun,
//     input [3:0] WdstM,
//     input [3:0] WdstE,
//     input [63:0] WvalE,
//     input [63:0] WvalM,
//     input Wcnd,

//     output reg [63:0] rm0,
//     output reg [63:0] rm1,
//     output reg [63:0] rm2,
//     output reg [63:0] rm3,
//     output reg [63:0] rm4,
//     output reg [63:0] rm5,
//     output reg [63:0] rm6,
//     output reg [63:0] rm7,
//     output reg [63:0] rm8,
//     output reg [63:0] rm9,
//     output reg [63:0] rm10,
//     output reg [63:0] rm11,
//     output reg [63:0] rm12,
//     output reg [63:0] rm13,
//     output reg [63:0] rm14
// );

// reg [3:0] Wicode;
// reg [3:0] Wifun;
// // wire [3:0] WdstM;
// // wire [3:0] WdstE;
// // wire [63:0] WvalE;
// // wire [63:0] WvalM;

// reg Wcnd;

//wb wuut(.clk(clk), .Wicode(Wicode), .Wifun(Wifun), .WdstM(WdstM), .WdstE(WdstE), .WvalE(WvalE), .WvalM(WvalM), .Wcnd(Wcnd), .rm0(rm0), .rm1(rm1), .rm2(rm2), .rm3(rm3), .rm4(rm4), .rm5(rm5), .rm6(rm6), .rm7(rm7), .rm8(rm8), .rm9(rm9), .rm10(rm10), .rm11(rm11), .rm12(rm12), .rm13(rm13), .rm14(rm14));


// module pc_update(
//     input clk,
//     input Mcnd,
//     input [3:0]Micode,
//     input [3:0]Wicode,
//     input [63:0]MvalA,
//     input [63:0]WvalM,
//     input [63:0]FpredPC,
//     output reg [63:0]nPC
// );

wire Mcnd;
// wire [63:0] MvalA;
// wire [63:0] WvalM;
wire [63:0] FpredPC;
wire [63:0] nPC;


pc_update puut(.clk(clk), .Mcnd(Mcnd), .Micode(Micode), .Wicode(Wicode), .MvalA(MvalA), .WvalM(WvalM), .FpredPC(FpredPC), .nPC(nPC));

// module logic(
//     input [3:0] Dicode,
//     input [3:0] Eicode,
//     input [3:0] Micode,
//     input [3:0] EdstM,
//     input [3:0] drA,
//     input [3:0] drB,

//     input ecnd,

//     output Fb,
//     output Fs,
//     output Db,
//     output Ds,
//     output Eb,
//     output Es

// );

wire Fb;
wire Fs;
wire Db;
wire Ds;
wire Eb;
wire Es;

logic1 luut(.Dicode(Dicode), .Eicode(Eicode), .Micode(Micode), .EdstM(EdstM), .dsrcA(dsrcA), .dsrcB(dsrcB), .ecnd(ecnd), .Fb(Fb), .Fs(Fs), .Db(Db), .Ds(Ds), .Eb(Eb), .Es(Es));

// wire [3:0] drA;
// wire [3:0] drB;



reg [63:0]rm[0:14];

// module freg(
//     input clk, 
//     input [63:0] prPC, 
//     output reg [63:0] FpredPC
// );

// wire [63:0] prPC;


freg fruut(.clk(clk), .prPC(prPC), .FpredPC(FpredPC));

// module dreg(
//     input clk,
//     input [3:0] ficode,
//     input [3:0] fifun,
//     input [3:0] frA,
//     input [3:0] frB,
//     input [63:0] fvalC,
//     input [63:0] fvalP,

//     output reg [3:0] Dicode,
//     output reg [3:0] Difun,
//     output reg [3:0] DrA,
//     output reg [3:0] DrB,

//     output reg [63:0] DvalC,
//     output reg [63:0] DvalP
// );


dreg druut(.clk(clk), .ficode(ficode), .fifun(fifun), .frA(frA), .frB(frB), .fvalC(fvalC), .fvalP(fvalP), .Dicode(Dicode), .Difun(Difun), .DrA(DrA), .DrB(DrB), .DvalC(DvalC), .DvalP(DvalP), .micode(micode), .mifun(mifun), .mdstM(mdstM), .mdstE(mdstE), .mvalE(mvalE), .mvalM(mvalM), .Wicode(Wicode), .Wifun(Wifun), .WdstE(WdstE), .WdstM(WdstM), .WvalE(WvalE), .WvalM(WvalM), .mcnd(mcnd));

// module ereg(
//     input clk,
//     input [3:0] dicode,
//     input [3:0] difun,
//     input [3:0] ddstE,
//     input [3:0] ddstM,
//     input [3:0] dsrcA,
//     input [3:0] dsrcB,
    
//     input [63:0] dvalA,
//     input [63:0] dvalB,
//     input [63:0] dvalC,
    
//     output reg [3:0] Eicode,
//     output reg [3:0] Eifun,
//     output reg [3:0] EdstM,
//     output reg [3:0] EdstE,
//     output reg [3:0] EsrcA,
//     output reg [3:0] EsrcB,

//     output reg [63:0] EvalA,
//     output reg [63:0] EvalB,
//     output reg [63:0] EvalC
// );

wire [3:0] EsrcA;
wire [3:0] EsrcB;


ereg eruut(.clk(clk), .dicode(dicode), .difun(difun), .ddstE(ddstE), .ddstM(ddstM), .dsrcA(dsrcA), .dsrcB(dsrcB), .dvalA(dvalA), .dvalB(dvalB), .dvalC(dvalC), .Eicode(Eicode), .Eifun(Eifun), .EdstM(EdstM), .EdstE(EdstE), .EsrcA(EsrcA), .EsrcB(EsrcB), .EvalA(EvalA), .EvalB(EvalB), .EvalC(EvalC));


// module mreg(
//     input clk,
//     input ecnd,

//     input [3:0] eicode,
//     input [3:0] eifun,
//     input [3:0] edstM,
//     input [3:0] edstE,

//     input [63:0] evalE,
//     input [63:0] evalA,

//     output reg [3:0] Micode,
//     output reg [3:0] MdstE,
//     output reg [3:0] MdstM,

//     output reg [63:0] MvalA,
//     output reg [63:0] MvalE,

//     output reg Mcnd
// );


mreg mruut(.clk(clk), .ecnd(ecnd), .eicode(eicode), .eifun(eifun), .edstM(edstM), .edstE(edstE), .evalE(evalE), .evalA(evalA), .Micode(Micode), .Mifun(Mifun), .MdstE(MdstE), .MdstM(MdstM), .MvalA(MvalA), .MvalE(MvalE), .Mcnd(Mcnd));


// module wbreg(
//     input clk,
//     input [3:0] micode,
//     input [3:0] mdstM,
//     input [3:0] mdstE,
//     input [63:0] mvalE,
//     input [63:0] mvalM,
    
//     output reg [3:0] Wicode,
//     output reg [3:0] Wifun,
//     output reg [3:0] WdstE,
//     output reg [3:0] WdstM,

//     output reg [63:0] WvalE,
//     output reg [63:0] WvalM,

//     output reg mcnd
// );

//wbreg wbruut(.clk(clk), .micode(micode), .mifun(mifun), .mdstM(mdstM), .mdstE(mdstE), .mvalE(mvalE), .mvalM(mvalM), .Wicode(Wicode), .Wifun(Wifun), .WdstE(WdstE), .WdstM(WdstM), .WvalE(WvalE), .WvalM(WvalM), .mcnd(mcnd));

initial
begin

    $dumpfile("procpipe.vcd");
    $dumpvars(0, procpipe);

    clk = 0;
    fPC = 64'd2; // INITIALIZE AS 0 TO SEE THE USE OF HALT

    $monitor("clk=%0d, fPC=%0d, ficode=%0d, fifun=%0d, frA=%0d, frB=%0d, fvalP=%0d, fvalC=%0d, Dicode=%0d, Eicode=%0d, Micode=%0d, Wicode=%0d, halt=%0d, r0=%0d, r1=%0d, r2=%0d, r3=%0d, r4=%0d, r5=%0d, r6=%0d, r7=%0d, r8=%0d, r9=%0d, r10=%0d, r11=%0d, r12=%0d, r13=%0d, r14=%0d", 
            clk, fPC, ficode, fifun, frA, frB, fvalP, fvalC, Dicode, Eicode, Micode, Wicode, halt, 
            rm0, rm1, rm2, rm3, rm4, rm5, rm6, rm7, rm8, rm9, rm10, rm11, rm12, rm13, rm14, "prPC=%0d FpredPC=%0d", prPC, FpredPC, "WdstE=%0d WvalE=%0d", WdstE, WvalE);
end

always #10 clk = ~clk;

always@(posedge clk)
begin

    fPC <= nPC; // ASSIGNING NEW PC VALUE

    if(halt == 1)
        $finish; // HALT FUNCTIONALITY
end

// always@(*)
// begin

// ughhh NOT WORKING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//     // rm0 = rm[0];
//     // rm1 = rm[1];
//     // rm2 = rm[2];
//     // rm3 = rm[3];
//     // rm4 = rm[4];
//     // rm5 = rm[5];
//     // rm6 = rm[6];
//     // rm7 = rm[7];
//     // rm8 = rm[8];
//     // rm9 = rm[9];
//     // rm10 = rm[10];
//     // rm11 = rm[11];
//     // rm12 = rm[12];
//     // rm13 = rm[13];
//     // rm14 = rm[14];
// end

endmodule