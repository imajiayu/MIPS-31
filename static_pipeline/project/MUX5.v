//名称：数据选择器（5位）
//input：M(选择信号，0或1)
//       jal(是否为jal指令)
//       in_A(输入端0)
//       in_B(输入端1)
//output:out(输出)

module MUX5(
    input M,
    input jal,
    input [4:0] in_A,
    input [4:0] in_B,
    output [4:0] out
);

    assign out=jal?5'b11111:(M?in_B:in_A);
endmodule