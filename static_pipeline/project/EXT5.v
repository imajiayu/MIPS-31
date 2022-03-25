//名称：符号拓展模块（5位）
//input：in_ext(5位输入)
//output:out_ext(32位输出)

module EXT5(
    input [4:0] in_ext,
    output [31:0] out_ext
);
    parameter WIDTH=27;
    assign out_ext={{(WIDTH){1'b0}},in_ext};
endmodule
