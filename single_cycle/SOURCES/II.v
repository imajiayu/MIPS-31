//名称：数据拼接模块
//input：in_A(A端输入)
//       in_B(B端输入)
//output:out(输出数据)

module II(
    input [3:0] in_A,
    input [25:0] in_B,
    output [31:0] out
);
    assign out={in_A,in_B,2'b00};
endmodule