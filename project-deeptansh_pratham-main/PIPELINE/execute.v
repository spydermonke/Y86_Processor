`timescale 1ns / 10ps

// A COPY OF SAME FINAL FILE OF ALU TO REDUCE THE HEADACHE OF INCLUDE COMMAND IS ADDED IN PIPELINE FOLDER

`include "alu.v"

module execute(
    input clk,
    input [3:0]Eicode,
    input [3:0]Eifun,
    input [3:0]EdstE,
    input [3:0]EdstM,
    input [63:0]EvalA,
    input [63:0]EvalB,
    input [63:0]EvalC,

    output reg signed [63:0] evalE,
    output reg signed [63:0] evalA,
    output reg [3:0] edstE,
    output reg [3:0] eicode,
    output reg [3:0] eifun,
    output reg [3:0] edstM,

    output reg ecnd,
    output reg z,
    output reg s,
    output reg o
);

always @(*)
begin

    // ASSIGNING FORMULAE TO FLAG BITS

    if(Eicode == 4'b0110 && clk == 1)
    begin
        z = (r == 1'b0);
        s = (r[63] == 1'b0);
        o = (p < 1'b0 == q < 1'b0) && (r < 1'b0 != p < 1'b0);
    end

end

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

// DEFINING IFUN PARAMETERS

parameter FRRMOVQ = 4'b0000;
parameter FCMOVLE = 4'b0001;
parameter FCMOVL = 4'b0010;
parameter FCMOVE = 4'b0011;
parameter FCMOVNE = 4'b0100;
parameter FCMOVGE = 4'b0101;
parameter FCMOVG = 4'b0110;
parameter FOPADD = 4'b0000;
parameter FOPSUB = 4'b0001;
parameter FOPAND = 4'b0010;
parameter FOPXOR = 4'b0011;
parameter FJMP = 4'b0000;
parameter FJLE = 4'b0001;
parameter FJL = 4'b0010;
parameter FJE = 4'b0011;
parameter FJNE = 4'b0100;
parameter FJGE = 4'b0101;
parameter FJG = 4'b0110;

// DEFINING SELECT LINES FOR ALU OPERATIONS

parameter OPAND = 2'b00;
parameter OPXOR = 2'b01;
parameter OPADD = 2'b10;
parameter OPSUB = 2'b11;

initial begin
    z = 0;
    s = 0;
    o = 0;
end

// select, p, q, r, ofw

reg [2:0] select;
reg signed [63:0] p;
reg signed [63:0] q;
wire signed [63:0] r;
wire ofw;

alu inst1(
    .select(select),
    .p(p),
    .q(q),
    .r(r),
    .ofw(ofw)
);

reg signed A1, A2, O1, O2, X1, X2, N1;
wire signed AO, OO, XO, NO;

and gate1(AO, A1, A2);
or gate2(OO, O1, O2);
xor gate3(XO, X1, X2);
not gate4(NO, N1);

initial begin

    select = 2'b00;
    p = 64'b0;
    q = 64'b0;

end

always @(*)
begin
    ecnd = 0;

    if(Eicode == CMOVXX)
    begin
        case(Eifun)

            FRRMOVQ:
            begin
            ecnd = 1;
            evalE = 64'd0 + EvalA;
            end

            FCMOVLE:
            begin
                X1 = s;
                X2 = o;
                if(XO)
                    begin
                        ecnd=1;
                    end
                else if(z)
                    begin
                        ecnd=1;
                    end
            end

            FCMOVL:
            begin
                X1 = s;
                X2 = o;
                if(XO)
                    begin
                        ecnd=1;
                    end
            end

            FCMOVE:
            begin
                if(z)
                begin
                    ecnd = 1;
                end
            end

            FCMOVNE:
            begin
                N1 = z;
                if(NO)
                begin
                    ecnd = 1;
                end
            end

            FCMOVGE:
            begin
                X1 = s;
                X2 = o;
                N1 = XO;

                if(NO)
                begin
                    ecnd = 1;
                end
            end

            FCMOVG:
            begin
                X1 = s;
                X2 = o;
                N1 = XO;
                if(NO)
                begin
                    N1 = z;
                    
                    if(NO)
                    begin
                        ecnd = 1;
                    end
                end
            end

        endcase

        evalE = 64'd0 + EvalA;
    end

    else if(Eicode == IRMOVQ)
    begin
        evalE = 64'd0 + EvalC;
    end

    else if(Eicode == RMMOVQ)
    begin
        evalE = EvalB + EvalC;
    end

    else if(Eicode == MRMOVQ)
    begin
        evalE = EvalB + EvalC;
    end

    else if(Eicode == OPQ)
    begin
        case(Eifun)

        FOPAND:
        begin
            select = OPAND;
            p = EvalA;
            q = EvalB;
        end

        FOPXOR:
        begin
            select = OPXOR;
            p = EvalA;
            q = EvalB;
        end

        FOPADD:
        begin
            select = OPADD;
            p = EvalA;
            q = EvalB;
        end

        FOPSUB:
        begin
            select = OPSUB;
            p = EvalA;
            q = EvalB;
        end

        endcase

        evalE = r;

    end

    else if(Eicode == JXX)
    begin
        case(Eifun)

        FJMP:
        begin
            ecnd = 1;
        end

        FJLE:
        begin
            X1 = s;
            X2 = o;

            if(XO)
            begin 
                ecnd = 1;
            end
            else if(z)
            begin
                ecnd = 1;
            end
        end

        FJL:
        begin
            X1 = s;
            X2 = o;

            if(XO)
            begin
                ecnd = 1;
            end
        end

        FJE:
        begin
            if(z)
            begin
                ecnd = 1;
            end
        end

        FJNE:
        begin
            N1 = z;

            if(NO)
            begin
                ecnd = 1;
            end
        end

        FJGE:
        begin
            X1 = s;
            X2 = o;
            N1 = XO;

            if(NO)
            begin
                ecnd = 1;
            end
        end

        FJG:
        begin
            X1 = s;
            X2 = o;
            N1 = XO;

            if(NO)
            begin
                N1 = z;
                
                if(NO)
                begin
                    ecnd = 1;
                end
            end
        end

        endcase
    end

    if(Eicode == CALL)
    begin
        evalE = -64'd8 + EvalB;
    end

    if(Eicode == RET)
    begin
        evalE = 64'd8 + EvalB;
    end

    if(Eicode == PUSHQ)
    begin
        evalE = -64'd8 + EvalB;
    end

    if(Eicode == POPQ)
    begin
        evalE = 64'd8 + EvalB;
    end

//end
end

// NOT MOVING CONDITION

always@(*)
begin
    if((Eicode == CMOVXX) && (!ecnd))
        edstE = 4'b1111;
    else
        edstE = EdstE;
end

// PASSING VALUES FROM INPUT STAGE TO CURRENT STAGE

always@(*)
begin
    eicode = Eicode;
    eifun = Eifun;
    evalA = EvalA;
    edstM = EdstM;
end

endmodule
