`timescale 1ns / 1ps

module alu_tb;

reg [2:0] select;
reg signed [63:0]p, q;
wire reg ofw;
wire reg signed [63:0]r;

alu inst (select, p, q, r, ofw);

initial begin
    $dumpfile("alu_tb.vcd");
    $dumpvars(0,alu_tb);
    {select} = 0;
    {p} = 0;
    {q} = 0;
end

initial begin
    #50
    {select} = 0;
    #50
    {p} = 69;
    #50 
    {q} = 96;
    #50
    $display("p = %b\nq = %b\nr = %b\nofw = %b", $signed(p), $signed(q), $signed(r), ofw);
    #50
    {select} = 1;
    #50
    {p} = 6;
    #50 
    {q} = 9;
    #50
    $display("p = %b\nq = %b\nr = %b\nofw = %b", $signed(p), $signed(q), $signed(r), ofw);
    #50
    {select} = 2;
    #50
    {p} = 4;
    #50 
    {q} = 456;
    #50
    $display("p = %b\nq = %b\nr = %b\nofw = %b", $signed(p), $signed(q), $signed(r), ofw);
    #50
    {select} = 3;
    #50
    {p} = 49;
    #50 
    {q} = 4;
    #50
    $display("p = %b\nq = %b\nr = %b\nofw = %b", $signed(p), $signed(q), $signed(r), ofw);
    #50
    {select} = 0;
    #50
    {p} = 67;
    #50 
    {q} = 9;
    #50
    $display("p = %b\nq = %b\nr = %b\nofw = %b", $signed(p), $signed(q), $signed(r), ofw);
    #50
    {select} = 1;
    #50
    {p} = 3;
    #50 
    {q} = 23;
    #50
    $display("p = %b\nq = %b\nr = %b\nofw = %b", $signed(p), $signed(q), $signed(r), ofw);
    #50
    {select} = 2;
    #50
    {p} = 34;
    #50 
    {q} = 56;
    #50
    $display("p = %b\nq = %b\nr = %b\nofw = %b", $signed(p), $signed(q), $signed(r), ofw);
    #50
    {select} = 3;
    #50
    {p} = 11;
    #50 
    {q} = 942;
    #50
    $display("p = %b\nq = %b\nr = %b\nofw = %b", $signed(p), $signed(q), $signed(r), ofw);
end

endmodule