//名称：寄存器堆
//input： clk(时钟信号)
//        rst:异步复位，高电平时全部寄存器置零
//        we:寄存器读写有效信号，1:写入，0:读出
//        raddr1:所需读取的寄存器的地址1
//        raddr2:所需读取的寄存器的地址2
//        waddr:写寄存器的地址
//        wdata:写寄存器数据，数据在 clk 下降沿时被写入
// output:rdata1:raddr1 所对应寄存器的输出数据
//        rdata2:raddr2 所对应寄存器的输出数据

module regfile (clk,rst,we,raddr1,raddr2,waddr,wdata,rdata1,rdata2);
    input clk;
    input rst;
    input we;

    input [4:0] raddr1;
    input [4:0] raddr2;
    input [4:0] waddr;
    input [31:0] wdata;
    output [31:0] rdata1;
    output [31:0] rdata2;



    reg [31:0] array_reg [0:31];
    integer cnt;
    
    always @(posedge rst) 
        for(cnt=0;cnt<32;cnt=cnt+1)
            array_reg[cnt]=32'b0;
    always @(posedge clk) 
    begin
        if(we)
        begin
            array_reg[waddr]=wdata;
        end
        array_reg[0]=32'b0;
    end
    assign rdata1=array_reg[raddr1];
    assign rdata2=array_reg[raddr2];

endmodule //regfile