`timescale 1ns / 10ps

module fetch(
    clk, 
    ficode, 
    fifun, 
    frA, 
    frB, 
    fvalC, 
    fvalP, 
    halt, 
    prPC, 
    fPC
);


//declaring the inputs
input clk;
input [63:0] fPC;

//declaring the outputs
output reg [3:0] ficode;
output reg [3:0] fifun;
output reg [3:0] frA;
output reg [3:0] frB;
output reg [63:0] fvalC;
output reg [63:0] fvalP;
output reg [63:0]prPC;


// declaring instruction memory
reg [7:0] mem [1023:0];

// defining condition checks
output reg halt;
output reg aok;
output reg ins;

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
  fvalC = 64'd0;
  fvalP = 64'd0;
  halt = 0;
end

initial begin

// mem[0] = 8'b00000000; // halt
// mem[1] = 8'b00010000; // NOP PC = 1 // UNCOMMENT TO TEST AND INITIALIZE 0 AS INITIAL VALUE OF PC (CURRENTLY IT IS 2)

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
mem[31] = 8'b01110100;
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


always @(*)
begin
    
    ficode = mem[fPC][7:4];
    fifun  = mem[fPC][3:0];

     if (ficode == HALT) //halt
    begin
        halt = 1'b1;
        fvalP = fPC + 64'd0;
    end

    else if(ficode == NOP) //nop
    begin 
        fvalP = fPC + 64'd1;
    end  

    else if(ficode == CMOVXX) //cmovXX
    begin
        frA = mem[fPC+1][7:4];
        frB = mem[fPC+1][3:0];
        fvalP = fPC + 64'd2;
    end 

    else if(ficode == IRMOVQ) //irmovq
    begin
       frA = mem[fPC+1][7:4];
       frB = mem[fPC+1][3:0];
       fvalC = {mem[fPC+9],
                mem[fPC+8],
                mem[fPC+7],
                mem[fPC+6],
                mem[fPC+5],
                mem[fPC+4],
                mem[fPC+3],
                mem[fPC+2]
                };
       fvalP = fPC + 64'd10;
    end  

    else if(ficode == RMMOVQ) //rmmovq
    begin
        frA = mem[fPC+1][7:4];
        frB = mem[fPC+1][3:0];
        fvalC = {mem[fPC+9],
                mem[fPC+8],
                mem[fPC+7],
                mem[fPC+6],
                mem[fPC+5],
                mem[fPC+4],
                mem[fPC+3],
                mem[fPC+2]
                };
        fvalP = fPC + 64'd10;
    end 


      else if(ficode == MRMOVQ) //mrmovq
    begin
        frA = mem[fPC+1][7:4];
        frB = mem[fPC+1][3:0];
        fvalC = {mem[fPC+9],
                mem[fPC+8],
                mem[fPC+7],
                mem[fPC+6],
                mem[fPC+5],
                mem[fPC+4],
                mem[fPC+3],
                mem[fPC+2]
                };
        fvalP = fPC + 64'd10;
    end 

      else if(ficode == OPQ) //Opq
    begin
        frA = mem[fPC+1][7:4];
        frB = mem[fPC+1][3:0];
        fvalP = fPC + 64'd2;
    end    
    
     else if(ficode == JXX) //jXX
    begin
          fvalC = {mem[fPC+8],
                mem[fPC+7],
                mem[fPC+6],
                mem[fPC+5],
                mem[fPC+4],
                mem[fPC+3],
                mem[fPC+2],
                mem[fPC+1]
                };
        fvalP = fPC + 64'd9;
    end  


    else if(ficode == CALL) //call
    begin
        fvalC = {mem[fPC+8],
                mem[fPC+7],
                mem[fPC+6],
                mem[fPC+5],
                mem[fPC+4],
                mem[fPC+3],
                mem[fPC+2],
                mem[fPC+1]
                };
        fvalP = fPC + 64'd9;
    end    
    
    else if(ficode == RET) //ret
    begin
        fvalP = fPC + 64'd1;
    end  

     
    else if(ficode == PUSHQ) //pushq
    begin
        frA = mem[fPC+1][7:4];
        frB = mem[fPC+1][3:0];
        fvalP = fPC + 64'd2;
    end    
    
    else if(ficode == POPQ) //popq    
    begin
        frA = mem[fPC+1][7:4];
        frB = mem[fPC+1][3:0];
        fvalP = fPC + 64'd2;
    end    

end

always @(*)       
begin
    if(ficode == 4'b0111 || ficode == 4'b1000)
    begin
        prPC = fvalC;
    end
    else
    begin
        prPC = fvalP;
    end
end

endmodule 

// PC Prediction (Separated in a callback module within fetch)

// module predict_pc(input [63:0]fvalP, 
//                   input [63:0]fvalC, 
//                   input [63:0]fPC, 
//                   input [63:0]ficode,
//                   output reg [63:0]prPC);


