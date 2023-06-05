`timescale 1ns / 10ps

module logic1 (
    input [3:0] Dicode,
    input [3:0] Eicode,
    input [3:0] Micode,
    input [3:0] EdstM,
    input [3:0] dsrcA,
    input [3:0] dsrcB,
    input ecnd,
    output reg Fb,
    output reg Fs,
    output reg Db,
    output reg Ds,
    output reg Eb,
    output reg Es
);

initial 
begin
    Fb = 0; // BUBBLE IN FETCH
    Fs = 0; // STALL IN FETCH
    Db = 0; // BUBBLE IN DECODE
    Ds = 0; // STALL IN DECODE
    Eb = 0; // BUBBLE IN EXECUTE
    Es = 0; // STALL IN EXECUTE 
end

// if else statements after these have been directly refered from the slides provided by sir

always @(*)
begin

    if(Eicode == 4'b0111 & ecnd == 4'b0000)
    begin
        Db = 1;
        Eb = 1;
    end

    else if((Eicode == 4'b0101 | Eicode == 4'b1011) & (EdstM == dsrcA | EdstM == dsrcB))
    begin
        Fs = 1;
        Ds = 1;
        Eb = 1;
    end

    else if(Eicode == 4'b1001 | Micode == 4'b1001 | Dicode == 4'b1001)
    begin
        Fs = 1;
        Db = 1;
    end
end

endmodule

