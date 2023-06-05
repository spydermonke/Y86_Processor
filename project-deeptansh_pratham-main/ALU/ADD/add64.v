`timescale 1ns / 1ps

module add64(p,q,r,ofw);

input signed [63:0]p, q;
output signed [63:0]r;
output ofw;

wire [64:0]c;
assign c[0] = 0;

genvar idx;

generate for(idx = 0; idx < 64; idx = idx + 1) begin
addg gate1(p[idx], q[idx], c[idx], r[idx], c[idx + 1]);
end
endgenerate

xor gate2(ofw, c[63], c[64]);

endmodule



