//名称：控制器
//input：clk(时钟信号)
//       [31:0] instruct(译码后的指令)
//       zero(ALU零标志位)
//       overflow(ALU溢出标志位)
//output:PC_clk(pcreg时钟信号)
//       PC_ena(pcreg使能信号)
//       RF_clk(regfiles时钟信号)
//       RF_we(regfiles读写信号)
//       DM_ena(DMEM使能信号)
//       DM_R(DMEM读信号)
//       DM_W(DMEM写信号)
//       sign(16位拓展符号)
//       A[3:0](ALU控制信号)
//       M(数据选择器控制信号)

module Controller(
    input clk,
    input [31:0] instruct,
    input zero,
    input overflow,
    output PC_clk,
    output PC_ena,
    output RF_clk,
    output RF_we,
    output DM_ena,
    output DM_R,
    output DM_W,
    output sign,
    output [3:0] A,
    output M0,
    output M1,
    output M2,
    output M3,
    output M4,
    output M5,
    output M6,
    output M7,
    output M8);

    assign PC_clk = clk;
    assign RF_clk=clk;
    assign PC_ena=1;
    assign DM_ena=instruct[22] | instruct[23];
    assign DM_W = instruct[23];
    assign DM_R = instruct[22];
    assign sign = ~(instruct[19]|instruct[20]|instruct[21]);
    assign RF_we = ~(instruct[16] | instruct[23] | instruct[24] | instruct[25] | instruct[29]) & ~overflow;
    assign A[0] = instruct[2] | instruct[3] | instruct[5] | instruct[7] | instruct[8] |
              instruct[11] | instruct[14] | instruct[20] | instruct[24] | instruct[25] | instruct[26];
    assign A[1] = instruct[0] | instruct[2] | instruct[6] | instruct[7] | instruct[8] |
              instruct[9] | instruct[10] | instruct[13] | instruct[17] | instruct[21] |
              instruct[22] | instruct[23] | instruct[24] | instruct[25] | instruct[26] | instruct[27];
    assign A[2] = instruct[4] | instruct[5] | instruct[6] | instruct[7] | instruct[10] |
              instruct[11] | instruct[12] | instruct[13] | instruct[14] | instruct[15] |
              instruct[19] | instruct[20] | instruct[21];
    assign A[3] = instruct[8] | instruct[9] | instruct[10] | instruct[11] | instruct[12] |
              instruct[13] | instruct[14] | instruct[15] | instruct[26] | instruct[27] |
              instruct[28];
    assign M0=instruct[24] | instruct[25];
    assign M1=instruct[16];
    assign M2=instruct[16] | (instruct[24]&zero)|(instruct[25]&~zero)|(instruct[29]|instruct[30]);
    assign M3=instruct[30];
    assign M4=instruct[17] | instruct[18] | instruct[19] | instruct[20] | instruct[21] |
              instruct[22] | instruct[23] | instruct[26] | instruct[27] | instruct[28];
    assign M5=instruct[13] | instruct[14] | instruct[15];
    assign M6=~instruct[22];
    assign M7=instruct[10] | instruct[11] | instruct[12] | instruct[13] | instruct[14] | instruct[15];
    assign M8=instruct[17] | instruct[18] | instruct[19] | instruct[20] | instruct[21] |
              instruct[22] | instruct[23] | instruct[26] | instruct[27] | instruct[28];

endmodule