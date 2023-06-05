`timescale 1ns / 1ps

module xorg(p,q,r);

input p;
input q;
output r;

xor gate1(r, p, q);

endmodule
