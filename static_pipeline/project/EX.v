`timescale 1ns / 1ps

module pipe_exe(
    input rst,
    input [31:0] pc4,
    input [31:0] rs_data_out,
    input [31:0] rt_data_out,
    input [31:0] imm,
    input [31:0] shamt,
    input [4:0] rf_waddr,
    input [3:0] aluc,  
    input dmem_ena,
    input cutter_sign,
    input rf_wena,       
    input dmem_wena,
    input [1:0] dmem_w_cs,
    input [1:0] dmem_r_cs,
    input cutter_mux_sel,
    input alu_mux1_sel,
    input [1:0] alu_mux2_sel,
    input [2:0] cutter_sel,
    input [2:0] rf_mux_sel, 
    output [31:0] exe_alu_out,  // Result of ALU
    output [31:0] exe_pc4,
    output [31:0] exe_rs_data_out,
    output [31:0] exe_rt_data_out,
    output [4:0] exe_rf_waddr,
    output exe_dmem_ena,
    output exe_rf_wena,       
    output exe_dmem_wena,
    output [1:0] exe_dmem_w_cs,
    output [1:0] exe_dmem_r_cs,
    output exe_cutter_sign,
    output exe_cutter_mux_sel,
    output [2:0] exe_cutter_sel,
    output [2:0] exe_rf_mux_sel
    );

    wire zero;
    wire carry;
    wire negative;
    wire overflow;
    wire [31:0] alu_in1;
    wire [31:0] alu_in2;

    assign exe_pc4 = pc4;
    assign exe_rs_data_out = rs_data_out;
    assign exe_rt_data_out = rt_data_out;
    assign exe_rf_waddr = rf_waddr;
    assign exe_dmem_ena = dmem_ena;
    assign exe_rf_wena = rf_wena;
    assign exe_dmem_wena = dmem_wena;
    assign exe_dmem_r_cs = dmem_r_cs;
    assign exe_dmem_w_cs = dmem_w_cs;
    assign exe_cutter_sign = cutter_sign;
    assign exe_cutter_mux_sel = cutter_mux_sel;
    assign exe_cutter_sel = cutter_sel;
    assign exe_rf_mux_sel = rf_mux_sel;

    mux_2_32 alu_mux1(
        .C0(shamt),
        .C1(rs_data_out),
        .S0(alu_mux1_sel),
        .oZ(alu_in1)
    );

    mux_4_32 alu_mux2(
        .C0(rt_data_out),
        .C1(imm),
        .C2(32'b0),
        .C3(32'b0),
        .S0(alu_mux2_sel),
        .oZ(alu_in2)
    );

    alu cpu_alu(
        .a(alu_in1), 
        .b(alu_in2), 
        .aluc(aluc), 
        .r(exe_alu_out),
        .zero(zero),
        .carry(carry),
        .negative(negative),
        .overflow(overflow)
    );

endmodule