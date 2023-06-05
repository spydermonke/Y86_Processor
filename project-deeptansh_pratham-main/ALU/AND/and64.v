`timescale 1ns / 1ps

module and64(p,q,r);

input signed [63:0]p, q;
output signed [63:0]r;

genvar idx;

generate for(idx = 0; idx < 64; idx = idx + 1) begin
  andg gate1(p[idx], q[idx], r[idx]);
end

endgenerate
endmodule