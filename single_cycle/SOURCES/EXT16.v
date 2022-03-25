//���ƣ�������չģ�飨16λ��
//input��in_ext(16λ����)
//       sign(�Ƿ������λ��չ)
//output:out_ext(32λ���)

module EXT16(
    input [15:0] in_ext,
    input sign,
    output [31:0] out_ext
);
    parameter WIDTH=16;
    assign out_ext=sign?{{(32-WIDTH){in_ext[WIDTH-1]}},in_ext}:
                        {{(32-WIDTH){1'b0}},in_ext};
endmodule
