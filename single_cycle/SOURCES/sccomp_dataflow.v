//名称：完整cpu
//input: clk(时钟信号)
//       rst(复位信号)
//output:inst(指令)
//      :pc(pc指向的地址)

module sccomp_dataflow(
    input clk_in,
    input reset,
    output [31:0] inst,
    output [31:0] pc);

    wire DM_ena;
    wire DM_R;
    wire DM_W;

    wire [31:0] inst_;
    wire [31:0] rdata;
    wire [31:0] pc_;
    wire [31:0] waddr;
    wire [31:0] wdata;

    CPU sccpu(.clk(clk_in),.rst(reset),.inst(inst_),.rdata(rdata),.pc(pc_),.waddr(waddr),.wdata(wdata),.DM_ena(DM_ena),.DM_R(DM_R),.DM_W(DM_W));
    DMEM dmem(.DM_ena(DM_ena),.DM_R(DM_R),.DM_W(DM_W),.addr((waddr-268500992)/4),.data_in(wdata),.data_out(rdata));
    dist_mem_gen_0 imem(.a((pc_-4194304)/4),.spo(inst_));

    assign inst=inst_;
    assign pc=pc_;

endmodule //cpu
