//名称：PC加法器
//input：in_npc(PC输入)
//output:out_npc(加4输出)

module NPC(
    input [31:0] in_npc,
    output [31:0] out_npc
);

    assign out_npc=in_npc+4;
endmodule