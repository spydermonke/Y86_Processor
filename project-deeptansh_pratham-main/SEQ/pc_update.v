`timescale 1ns / 10ps

module pc_update(
    input clk,
    input cnd,
    input [3:0]icode,
    input [3:0]ifun,
    input [63:0]valC,
    input [63:0]valP,
    input [63:0]valF,
    input [63:0]PC,
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

always @(*)
begin
    
    case(icode)

    JXX:
    begin
        if(cnd == 1)
        begin
            nPC = valC;
        end
        else
        begin
            nPC = valP;
        end
    end

    CALL:
    begin
        nPC = valC;
    end

    RET:
    begin
        nPC = valF;
    end

    default:
    begin
        nPC = valP;
    end

    endcase

end

endmodule
