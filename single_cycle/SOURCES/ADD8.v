//名称：加8加法器
//input：in(加数)
//output:out(输出)

module ADD8(
    input [31:0] in,
    output [31:0] out
    );
    assign out = in + 4;
endmodule