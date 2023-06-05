`timescale 1ns/10ps

module decode(
    input clk,
    input cnd,
    input [3:0] rA,
    input [3:0] rB,
    input [63:0] valE,
    input [63:0] valF,
    input [3:0] icode,
    input [3:0] ifun,

    output reg [63:0] valA,
    output reg [63:0] valB,

    output reg [63:0] rm0,
    output reg [63:0] rm1,
    output reg [63:0] rm2,
    output reg [63:0] rm3,
    output reg [63:0] rm4,
    output reg [63:0] rm5,
    output reg [63:0] rm6,
    output reg [63:0] rm7,
    output reg [63:0] rm8,
    output reg [63:0] rm9,
    output reg [63:0] rm10,
    output reg [63:0] rm11,
    output reg [63:0] rm12,
    output reg [63:0] rm13,
    output reg [63:0] rm14
);

reg [63:0]rm[0:14];

initial begin

// ASSIGNED COUNTER VALUES FOR CHECKING OUTPUTS

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

    valA = 64'd0;
    valB = 64'd0;
end

// DEFINING PARAMETERS FOR ICODE

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


always @(*) begin

    case(icode)

    CMOVXX:
    begin
    valA = rm[rA];
    end

    RMMOVQ:
    begin
    valA = rm[rA];
    valB = rm[rB];
    end

    MRMOVQ:
    begin
    valB = rm[rB];
    end

    OPQ:
    begin
    valA = rm[rA];
    valB = rm[rB];
    end

    CALL:
    begin
    valB = rm[4];
    end

    RET:
    begin
    valA = rm[4];
    valB = rm[4];
    end

    PUSHQ:
    begin
    valA = rm[rA];
    valB = rm[4];
    end

    POPQ:
    begin
    valA = rm[4];
    valB = rm[4];
    end

    endcase

    rm0 = rm[0];
    rm1 = rm[1];
    rm2 = rm[2];
    rm3 = rm[3];
    rm4 = rm[4];
    rm5 = rm[5];
    rm6 = rm[6];
    rm7 = rm[7];
    rm8 = rm[8];
    rm9 = rm[9];
    rm10 = rm[10];
    rm11 = rm[11];
    rm12 = rm[12];
    rm13 = rm[13];
    rm14 = rm[14];

end

//WRITE BACK IS IMPLEMENTED IN DECODE STAGE ONLY FOR EASY ACCESS TO valE AND INSTRUCTION MEMORY

always @ (posedge clk)
    begin
        if(icode == CMOVXX && ifun == 4'b0)
        begin
            rm[rB] = valE;
        end
        if(icode == CMOVXX && ifun != 4'b0 && cnd == 1)
        begin
            // if(cnd)
            // begin
                 rm[rB] = valE;
            // end
            // else
            // begin
            //     rm[14] = valE;
            // end

            // UGHHHHHHH SILLY ERRORRRRRRRRRRRRR!!!!!!!!!!!!!!

            // case(cnd)

            // 1'b1:
            // begin
            //     rm[rB] = valE;
            // end

            // default:
            // begin
            //     rm[14] = valE;
            // end

            // endcase
        end

        else if(icode == IRMOVQ)
        begin
        rm[rB] = valE;
        end

        else if(icode == MRMOVQ)
        begin
        rm[rA] = valF;
        end

        else if(icode == OPQ)
        begin
        rm[rB] = valE;
        end

        else if(icode == CALL)
        begin
        rm[4] = valE;
        end

        else if(icode == RET)
        begin
        rm[4] = valE;
        end

        else if(icode == PUSHQ)
        begin
        rm[4] = valE;
        end

        else if(icode == POPQ)
        begin
        rm[4] = valE;
        rm[rA] = valF;
        end


        rm0 = rm[0];
        rm1 = rm[1];
        rm2 = rm[2];
        rm3 = rm[3];
        rm4 = rm[4];
        rm5 = rm[5];
        rm6 = rm[6];
        rm7 = rm[7];
        rm8 = rm[8];
        rm9 = rm[9];
        rm10 = rm[10];
        rm11 = rm[11];
        rm12 = rm[12];
        rm13 = rm[13];
        rm14 = rm[14];

   end

endmodule

