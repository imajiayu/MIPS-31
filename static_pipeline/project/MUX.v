//名称：数据选择器（32位）
//input：M(选择信号，0或1)
//       in_A(输入端0)
//       in_B(输入端1)
//output:out(输出)

module MUX(
    input M,
    input [31:0] in_A,
    input [31:0] in_B,
    output [31:0] out
);

    assign out=M?in_B:in_A;
endmodule