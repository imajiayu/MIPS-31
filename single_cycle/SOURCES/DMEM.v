//名称：数据存储器
//input：DM_ena(使能信号)
//       DM_R(读取信号)
//       DM_w(写入信号)
//       addr(读取或写入的地址)
//       data_in(写入的数据)
//output:data_out(输出)

module DMEM(
    input DM_ena,
    input DM_R,
    input DM_W,
    input [31:0] addr,
    input [31:0] data_in,
    output [31:0] data_out
);
    reg [31:0] dram [2047:0];

    assign data_out=DM_ena?(DM_R?dram[addr[9:0]]:32'bx):32'bx;
    always @(addr or DM_W) 
    begin
        if(DM_W&&DM_ena)
            dram[addr[9:0]]=data_in;
    end
endmodule