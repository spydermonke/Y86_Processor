`timescale 1ns / 1ps

module xor64(p,q,r);

input signed [63:0]p;
input signed [63:0]q;
output signed [63:0]r;

genvar idx;

generate for(idx = 0; idx < 64; idx = idx + 1) begin
  xorg gate1(p[idx], q[idx], r[idx]);
end

endgenerate
endmodule