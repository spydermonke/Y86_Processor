`timescale 1ns / 1ps

module add64_tb;

reg signed [63:0]p,q,c;
wire signed [63:0] r;
wire reg cout;

add64 inst (p,q,r,carry);

initial begin
    $dumpfile("add64_tb.vcd");
    $dumpvars(0, add64_tb);
    {p} = 0;
    {q} = 0;
    {c} = 0;
end

initial begin

    #50
    {p} = 2147483648;
    #50
    {q} = 2147483648;
    #50
    {c} = 0;
    #50
    $display("time = %0t \t\np = %b\nq = %b\nr = %b\ncarry = %b", $time, $signed(p), $signed(q), $signed(r), $signed(carry));
    #50
    {p} = 4;
    #50
    {q} = 5;
    #50
    {c} = 0;
    #50
    $display("time = %0t \t\np = %b\nq = %b\nr = %b\ncarry = %b", $time, $signed(p), $signed(q), $signed(r), $signed(carry));
    #50
    {p} = 14;
    #50
    {q} = 9;
    #50
    {c} = 1;
    #50
    $display("time = %0t \t\np = %b\nq = %b\nr = %b\ncarry = %b", $time, $signed(p), $signed(q), $signed(r), $signed(carry));
    #50
    {p} = -95;
    #50
    {q} = 23;
    #50
    {c} = 11;
    #50
    $display("time = %0t \t\np = %b\nq = %b\nr = %b\ncarry = %b", $time, $signed(p), $signed(q), $signed(r), $signed(carry));
    #50
    {p} = 44;
    #50
    {q} = 4;
    #50
    {c} = -3;
    #50
    $display("time = %0t \t\np = %b\nq = %b\nr = %b\ncarry = %b", $time, $signed(p), $signed(q), $signed(r), $signed(carry));

end

endmodule