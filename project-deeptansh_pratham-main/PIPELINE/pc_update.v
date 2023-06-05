// PC_UPDATE IS SELECT_PC ONLY IDK WHY I KEPT THIS NAME!

`timescale 1ns / 10ps

module pc_update(
    input clk,
    input Mcnd,
    input [3:0]Micode,
    input [3:0]Wicode,
    input [63:0]MvalA,
    input [63:0]WvalM,
    input [63:0]FpredPC,
    output reg [63:0]nPC
);

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

initial begin
nPC = 64'd2; // BECAUSE FIRST INSTRUCTION IS HALT, TO USE THIS UNCOMMENT FIRST INSTRUCTION OF HALT AND INITIALIZE 0 HERE
end

always @(*)
begin
    
    case(Micode)

    JXX:
    begin
        if(Mcnd == 0)
        begin
            nPC <= MvalA;
        end
    end

    default:
    begin
        nPC = FpredPC; // FpredPC IS COMING FROM FREG MODULE KA OUTPUT
    end

    endcase

    case(Wicode)

    RET:
    begin
        nPC = WvalM;
    end

    default:
    begin
        nPC = FpredPC;
    end

    endcase


end

endmodule
