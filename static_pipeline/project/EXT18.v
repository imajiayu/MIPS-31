//名称：符号拓展模块（18位）
//input：in_ext(16位输入,左移2两位)
//output:out_ext(32位输出)

module EXT18(
    input [15:0] in_ext,
    output [31:0] out_ext
);
    parameter WIDTH=14;
    assign out_ext={{(WIDTH){1'b0}},in_ext,2'b0};
endmodule
