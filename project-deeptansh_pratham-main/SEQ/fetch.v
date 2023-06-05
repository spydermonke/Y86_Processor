module fetch(clk, PC, icode, ifun, rA, rB, valC, valP, halt);

input clk;
input [63:0] PC;
output reg [3:0] icode;
output reg [3:0] ifun;
output reg [3:0] rA;
output reg [3:0] rB;
output reg [63:0] valC;
output reg [63:0] valP;
output reg halt;
reg [7:0] mem [1023:0];

initial begin
  valC = 64'd0;
  valP = 64'd0;
  halt = 0;
end

// PARAMETERS DEFINED FOR ICODE

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

mem[0] = 8'b00000000; // halt
mem[1] = 8'b00010000; // NOP PC = 1

mem[2] = 8'b00110000; // IRMOVQ PC = 12
mem[3] = 8'b11110010; // F rB = 2
mem[4] = 8'b10101010;
mem[5] = 8'b00000000;
mem[6] = 8'b00000000;
mem[7] = 8'b00000000;
mem[8] = 8'b00000000;
mem[9] = 8'b00000000;
mem[10] = 8'b00000000;
mem[11] = 8'b00000000;

mem[12] = 8'b00110000; // IRMOVQ PC = 22
mem[13] = 8'b11110011; // F rB = 3
mem[14] = 8'b11001011;
mem[15] = 8'b00000000;
mem[16] = 8'b00000000;
mem[17] = 8'b00000000;
mem[18] = 8'b00000000;
mem[19] = 8'b00000000;
mem[20] = 8'b00000000;
mem[21] = 8'b00000000;

mem[22] = 8'b00100000; // RRMOVQ PC = 24
mem[23] = 8'b00110100; // rA = 3 rB = 4

mem[24] = 8'b01100000; // OPQ ADD PC = 26
mem[25] = 8'b00100100; // adding rA = 2 and rB = 4 and storing into rB = 4

mem[26] = 8'b01100001; // OPQ SUB PC = 28
mem[27] = 8'b00110101; // rA = 3 rB = 5

// FOR CMOVXX TO WORK VIA CMOVLE

mem[28] = 8'b00100001; // CMOVLE PC = 30
mem[29] = 8'b01010110; // rA = 5 rB = 6

// FOR CMOVXX NOT TO WORK VIA CMOVG

// mem[28] = 8'b00100001; // CMOVLE PC = 30
// mem[29] = 8'b01010110; // rA = 5 rB = 6

// FOR JUMP INSTRUCTION TO WORK

mem[30] = 8'b01110010; // JL PC = 39
mem[31] = 8'b01110101;
mem[32] = 8'b00000000;
mem[33] = 8'b00000000;
mem[34] = 8'b00000000;
mem[35] = 8'b00000000;
mem[36] = 8'b00000000;
mem[37] = 8'b00000000;
mem[38] = 8'b00000000;

// FOR JUMP INSTRUCTION NOT TO WORK

// mem[30] = 8'b01110101; // JGE PC = 39
// mem[31] = 8'b01110101;
// mem[32] = 8'b00000000;
// mem[33] = 8'b00000000;
// mem[34] = 8'b00000000;
// mem[35] = 8'b00000000;
// mem[36] = 8'b00000000;
// mem[37] = 8'b00000000;
// mem[38] = 8'b00000000;

// VERIFY THAT MEMORY IS WORKING
// AT THIS STAGE mem[203] HAS THE CURRENT VALUE

mem[39] = 8'b01010000; // MRMOVQ PC = 49
mem[40] = 8'b11100011; // rA = 14 rB = 3
mem[41] = 8'b00000000;
mem[42] = 8'b00000000;
mem[43] = 8'b00000000;
mem[44] = 8'b00000000;
mem[45] = 8'b00000000;
mem[46] = 8'b00000000;
mem[47] = 8'b00000000;
mem[48] = 8'b00000000;

end

always @ (*)
    begin
        if(PC > 1023)
        begin
            $display("Memory Error");
        end

        ifun = mem[PC][3:0];
        icode = mem[PC][7:4];

        if (icode == HALT)
        begin
        halt = 1;
        valP = PC + 1;
        end

        else if (icode == NOP)
        begin
        valP = PC + 1;
        end

        else if (icode == CMOVXX)
        begin
        rA = mem[PC + 1][7:4];
        rB = mem[PC + 1][3:0];
        valP = PC + 2;
        end

        else if (icode == IRMOVQ)
        begin
        rA = mem[PC + 1][7:4];
        rB = mem[PC + 1][3:0];
        valC = {mem[PC + 9], mem[PC + 8], mem[PC + 7], mem[PC + 6], mem[PC + 5], mem[PC + 4], mem[PC + 3], mem[PC + 2]};
        valP = PC + 10;
        end

        else if (icode == RMMOVQ)
        begin
        rA = mem[PC + 1][7:4];
        rB = mem[PC + 1][3:0];
        valC = {mem[PC + 9], mem[PC + 8], mem[PC + 7], mem[PC + 6], mem[PC + 5], mem[PC + 4], mem[PC + 3], mem[PC + 2]};
        valP = PC + 10;
        end

        else if (icode == MRMOVQ)
        begin
        rA = mem[PC + 1][7:4];
        rB = mem[PC + 1][3:0];
        valC = {mem[PC + 9], mem[PC + 8], mem[PC + 7], mem[PC + 6], mem[PC + 5], mem[PC + 4], mem[PC + 3], mem[PC + 2]};
        valP = PC + 10;
        end

        else if (icode == OPQ)
        begin
        rA = mem[PC + 1][7:4];
        rB = mem[PC + 1][3:0];
        valP = PC + 2;
        end

        else if (icode == JXX)
        begin
        valC = {mem[PC + 8], mem[PC + 7], mem[PC + 6], mem[PC + 5], mem[PC + 4], mem[PC + 3], mem[PC + 2], mem[PC + 1]};
        valP = PC + 9;
        end

        else if (icode == CALL)
        begin
        valC = {mem[PC + 8], mem[PC + 7], mem[PC + 6], mem[PC + 5], mem[PC + 4], mem[PC + 3], mem[PC + 2], mem[PC + 1]};
        valP = PC + 9;
        end

        else if (icode == RET)
        begin
        valP = PC + 1;
        end

        else if (icode == PUSHQ)
        begin
        rA = mem[PC + 1][7:4];
        rB = mem[PC + 1][3:0];
        valP = PC + 2;
        end

        else if (icode == POPQ)
        begin
        rA = mem[PC + 1][7:4];
        rB = mem[PC + 1][3:0];
        valP = PC + 2;
        end

    end

endmodule






        


