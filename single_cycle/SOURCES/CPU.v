//名称：实例化的CPU(除IMEM与DMEM)
//input：clk
//       rst(regfile和pcreg的复位信号)
//       inst(IMEM指令输入)
//       rdata(DMEM读出数据)
//output:pc(指令地址)
//       waddr(DMEM写入地址)
//       wdata(DMEM写入数据)
//       DM_ena(DMEM使能信号)
//       DM_R(DMEM读信号)
//       DM_W(DMEM写信号)


module CPU(
    input clk,
    input rst,
    input [31:0] inst,
    input [31:0] rdata,
    output [31:0] pc,
    output [31:0] waddr,
    output [31:0] wdata,
    output DM_ena,
    output DM_R,
    output DM_W);

    //译码器输出
    wire [31:0] instruct;

    //alu发出信号
    wire [31:0] r_alu;
    wire zero_alu;
    wire overflow_alu;

    //controller发出信号
    wire PC_clk_con;
    wire PC_ena_con;
    wire RF_clk_con;
    wire RF_we_con;
    wire DM_ena_con;
    wire DM_R_con;
    wire DM_W_con;
    wire sign_con;
    wire [3:0] A_con;
    wire M0_con;
    wire M1_con;
    wire M2_con;
    wire M3_con;
    wire M4_con;
    wire M5_con;
    wire M6_con;
    wire M7_con;
    wire M8_con;

    //npc输出
    wire [31:0] npc_out;

    //regfile输出
    wire [31:0] RF_rs;
    wire [31:0] RF_rt;

    //pcreg输出
    wire [31:0] PC_out;

    //add输出
    wire [31:0] add_out;
    wire [31:0] add8_out;

    //II模块输出
    wire [31:0] II_out;

    //mux输出
    wire [31:0] M0_out;
    wire [31:0] M1_out;
    wire [31:0] M2_out;
    wire [31:0] M3_out;
    wire [4:0] M4_out;
    wire [4:0] M5_out;
    wire [31:0] M6_out;
    wire [31:0] M7_out;
    wire [31:0] M8_out;

    //ext输出
    wire [31:0] ext5_out;
    wire [31:0] ext16_out;
    wire [31:0] ext18_out;



    Decoder decoder(.code(inst),.instruct(instruct));
    Controller controller(.clk(clk),.instruct(instruct),.zero(zero_alu),.overflow(overflow_alu),.PC_clk(PC_clk_con),.PC_ena(PC_ena_con),.RF_clk(RF_clk_con),.RF_we(RF_we_con),.DM_ena(DM_ena),.DM_R(DM_R),.DM_W(DM_W),.sign(sign_con),.A(A_con),.M0(M0_con),.M1(M1_con),.M2(M2_con),.M3(M3_con),.M4(M4_con),.M5(M5_con),.M6(M6_con),.M7(M7_con),.M8(M8_con));
    ALU alu(.a(M7_out),.b(M8_out),.aluc(A_con),.r(r_alu),.zero(zero_alu),.overflow(overflow_alu));
    regfile cpu_ref(.clk(RF_clk_con),.rst(rst),.we(RF_we_con),.raddr1(inst[25:21]),.raddr2(inst[20:16]),.waddr(M4_out),.wdata(M3_out),.rdata1(RF_rs),.rdata2(RF_rt));
    PCREG pcreg(.clk(PC_clk_con),.rst(rst),.ena(PC_ena_con),.data_in(M2_out),.data_out(PC_out));
    NPC npc(.in_npc(PC_out),.out_npc(npc_out));
    II ii(.in_A(PC_out[31:28]),.in_B(inst[25:0]),.out(II_out));
    EXT5 ext5(.in_ext(M5_out),.out_ext(ext5_out));
    EXT16 ext16(.in_ext(inst[15:0]),.sign(sign_con),.out_ext(ext16_out));
    EXT18 ext18(.in_ext(inst[15:0]),.out_ext(ext18_out));
    ADD add(.in_A(ext18_out),.in_B(npc_out),.out(add_out));
    ADD8 add8(.in(PC_out),.out(add8_out));

    MUX mux0(.M(M0_con),.in_A(II_out),.in_B(add_out),.out(M0_out));
    MUX mux1(.M(M1_con),.in_A(M0_out),.in_B(RF_rs),.out(M1_out));
    MUX mux2(.M(M2_con),.in_A(npc_out),.in_B(M1_out),.out(M2_out));
    MUX mux3(.M(M3_con),.in_A(M6_out),.in_B(add8_out),.out(M3_out));
    MUX5 mux4(.M(M4_con),.jal(instruct[30]),.in_A(inst[15:11]),.in_B(inst[20:16]),.out(M4_out));
    MUX5 mux5(.M(M5_con),.jal(instruct[30]),.in_A(inst[10:6]),.in_B(RF_rs[4:0]),.out(M5_out));
    MUX mux6(.M(M6_con),.in_A(rdata),.in_B(r_alu),.out(M6_out));
    MUX mux7(.M(M7_con),.in_A(RF_rs),.in_B(ext5_out),.out(M7_out));
    MUX mux8(.M(M8_con),.in_A(RF_rt),.in_B(ext16_out),.out(M8_out));
    
    assign waddr=r_alu;
    assign wdata=RF_rt;
    assign pc=PC_out;

endmodule