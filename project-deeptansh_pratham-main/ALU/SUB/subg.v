`timescale 1ns / 1ps

module subg (p,q,r,ofw);

input signed [63:0] p, q;
output ofw;
output signed [63:0] r;

wire [63:0]c;

genvar idx;
for (idx = 0; idx < 64; idx = idx + 1) begin
    not gate1 (c[idx],q[idx]);
end

wire [63:0]ob;
assign ob = 1;

wire [63:0]def;

add64 gate2(c, ob, def, dummy);

add64 gate3(p, def, r, ofw);


endmodule