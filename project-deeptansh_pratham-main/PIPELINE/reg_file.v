// REGISTER FILE FOR ALL THE STAGES

`timescale 1ns / 10ps

// Fetch Register

module freg(
    input clk, 
    input [63:0] prPC, 
    output reg [63:0] FpredPC
);

always @(posedge clk)
begin
    FpredPC <= prPC;
end

endmodule

// Decode Register

module dreg(
    input clk,
    input [3:0] ficode,
    input [3:0] fifun,
    input [3:0] frA,
    input [3:0] frB,
    input [63:0] fvalC,
    input [63:0] fvalP,

    output reg [3:0] Dicode,
    output reg [3:0] Difun,
    output reg [3:0] DrA,
    output reg [3:0] DrB,

    output reg [63:0] DvalC,
    output reg [63:0] DvalP,


    input [3:0] micode,
    input [3:0] mifun,
    input [3:0] mdstM,
    input [3:0] mdstE,
    input [63:0] mvalE,
    input [63:0] mvalM,
    
    output reg [3:0] Wicode,
    output reg [3:0] Wifun,
    output reg [3:0] WdstE,
    output reg [3:0] WdstM,

    output reg [63:0] WvalE,
    output reg [63:0] WvalM,

    output reg mcnd
);

always @(posedge clk)
begin
    Dicode <= ficode;
    Difun <= fifun;
    DvalC <= fvalC;
    DvalP <= fvalP;
    DrA <= frA;
    DrB <= frB;

    Wicode <= micode;
    Wifun <= mifun;
    WvalM <= mvalM;
    WdstE <= mdstE;
    WdstM <= mdstM;
    WvalE <= mvalE;
end

endmodule

// Execute register file

module ereg(
    input clk,
    input [3:0] dicode,
    input [3:0] difun,
    input [3:0] ddstE,
    input [3:0] ddstM,
    input [3:0] dsrcA,
    input [3:0] dsrcB,
    
    input [63:0] dvalA,
    input [63:0] dvalB,
    input [63:0] dvalC,
    
    output reg [3:0] Eicode,
    output reg [3:0] Eifun,
    output reg [3:0] EdstM,
    output reg [3:0] EdstE,
    output reg [3:0] EsrcA,
    output reg [3:0] EsrcB,

    output reg [63:0] EvalA,
    output reg [63:0] EvalB,
    output reg [63:0] EvalC
);

always @(posedge clk)
begin
    Eicode <= dicode;
    Eifun <= difun;
    EdstM <= ddstM;
    EdstE <= ddstE;
    EsrcA <= dsrcA;
    EsrcB <= dsrcB;
    EvalA <= dvalA;
    EvalB <= dvalB;
    EvalC <= dvalC;
end

endmodule

// Memory register

module mreg(
    input clk,
    input ecnd,

    input [3:0] eicode,
    input [3:0] eifun,
    input [3:0] edstM,
    input [3:0] edstE,

    input [63:0] evalE,
    input [63:0] evalA,

    output reg [3:0] Micode,
    output reg [3:0] Mifun,
    output reg [3:0] MdstE,
    output reg [3:0] MdstM,

    output reg [63:0] MvalA,
    output reg [63:0] MvalE,

    output reg Mcnd
);

always @(posedge clk)
    begin
        Micode <= eicode;
        Mifun <= eifun;
        Mcnd <= ecnd;
        MvalA <= evalA;
        MdstE <= edstE;
        MdstM <= edstM;
        MvalE <= evalE;
    end
endmodule

// write_back register

// module wbreg(
//     input clk,
//     input [3:0] micode,
//     input [3:0] mifun,
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

// always @(posedge clk)
//     begin
//         Wicode <= micode;
//         Wifun <= mifun;
//         WvalM <= mvalM;
//         WdstE <= mdstE;
//         WdstM <= mdstM;
//         WvalE <= mvalE;
//     end

