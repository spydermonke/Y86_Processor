`timescale 1ns / 1ps
`include "../ALU/ADD/add64.v"
`include "../ALU/ADD/addg.v"
`include "../ALU/AND/and64.v"
`include "../ALU/AND/andg.v"
// `include "../SUB/add64.v"
// `include "../SUB/addg.v"
`include "../ALU/SUB/subg.v"
`include "../ALU/XOR/xor64.v"
`include "../ALU/XOR/xorg.v"

module alu(select, p, q, r, ofw);

input [2:0] select;
input signed [63:0] p, q;
output reg signed [63:0] r;
output reg ofw;

wire signed [63:0] and_out, xor_out, add_out, sub_out;
wire and_ofw, xor_ofw, add_ofw, sub_ofw;


and64 sel_and(p, q, and_out);
xor64 sel_xor(p, q, xor_out);
add64 sel_add(p, q, add_out, add_ofw);
subg sel_sub(p, q, sub_out, sub_ofw);

always @(*)
begin

if (select == 2'b00) begin
    r = and_out;
    ofw = 0;
end

else if(select == 2'b01) begin
    r = xor_out;
    ofw = 0;
end

else if(select == 2'b10) begin
    r = add_out;
    ofw = add_ofw;
end

else if(select == 2'b11) begin
    r = sub_out;
    ofw = sub_ofw;
end

end

endmodule