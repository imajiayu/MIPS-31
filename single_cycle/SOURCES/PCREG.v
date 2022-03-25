//名称：PC寄存器
//input：clk(时钟信号)
//       rst(置位)
//       ena(使能信号)
//       data_in(输入数据)
//output:data_out(输出数据)

module PCREG(clk,rst,ena,data_in,data_out);
    input clk;
    input rst;
    input ena;
    input [31:0] data_in;
    output reg [31:0] data_out;

    always @ (negedge clk,posedge rst,posedge ena)
    begin
        if(rst)
            data_out=32'h00400000;
        else if(~clk)
        begin
            if(ena)
                data_out=data_in;
            else begin end
        end
        else begin end
    end

endmodule