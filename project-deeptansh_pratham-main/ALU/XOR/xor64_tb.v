`timescale 1ns / 1ps

module xor64_tb;

reg signed [63:0]p,q;
wire signed [63:0] r;

xor64 inst (p,q,r);

initial begin
    $dumpfile("xor64_tb.vcd");
    $dumpvars(0, xor64_tb);
    {p} = 0;
    {q} = 0;
end

initial begin

    #50
    {p} = 69;
    #50
    {q} = -96;
    #50
    $display("time = %0t \t\np = %b\nq = %b\nr = %b", $time, $signed(p), $signed(q), $signed(r));
    #50
    {p} = 4;
    #50
    {q} = 5;
    #50
    $display("time = %0t \t\np = %b\nq = %b\nr = %b", $time, $signed(p), $signed(q), $signed(r));
    #50
    {p} = 14;
    #50
    {q} = 9;
    #50
    $display("time = %0t \t\np = %b\nq = %b\nr = %b", $time, $signed(p), $signed(q), $signed(r));
    #50
    {p} = -95;
    #50
    {q} = 23;
    #50
    $display("time = %0t \t\np = %b\nq = %b\nr = %b", $time, $signed(p), $signed(q), $signed(r));
    #50
    {p} = 44;
    #50
    {q} = 4;
    #50
    $display("time = %0t \t\np = %b\nq = %b\nr = %b", $time, $signed(p), $signed(q), $signed(r));

end

endmodule