`timescale 1ns / 1ps

module addg(p,q,c,r,carry);

input p;
input q;
input c;
output r;
output carry;

wire w1, w2, w3;

xor gate1(r, p, q, c);
and gate2(w1, p, q);
and gate3(w2, p, c);
and gate4(w3, q, c);
or gate5(carry, w1, w2, w3);

endmodule