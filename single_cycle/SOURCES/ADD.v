//名称：加法器
//input：in_A(加数)
//       in_B(加数)
//output:out(输出)

module ADD(
    input [31:0] in_A,
    input [31:0] in_B,
    output [31:0]out
    );
    assign out = in_A + in_B;
endmodule
