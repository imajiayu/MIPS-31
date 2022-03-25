`timescale 1ns / 1ps


module pipe_top(
    input clk,
    input rst,
    output [31:0] instruction,
    output [31:0] pc,
    output [7:0] o1,
    output [7:0] o2,
    output [7:0] o3
    );

    parameter T1s = 2;

    reg [30:0] count;
    reg clk_1s;

    wire [31:0] instruction;
    wire [31:0] pc;
    wire [31:0] reg11;
    wire [31:0] reg12;
    wire [31:0] reg13;

    always @ (posedge clk or posedge rst) 
    begin
        if(rst) begin
            clk_1s <= 0;
            count <= 0;
        end
        else if(count == T1s) begin
            count <= 0;
            clk_1s <= ~clk_1s;
        end
        else
            count <= count + 1;
    end

    cpu_top cpu(
        .clk(clk_1s),
        .rst(rst),
        .instruction(instruction),
        .pc(pc),
        .reg11(reg11),
        .reg12(reg11),
        .reg13(reg13)
    );
    
    seg7x16 seg7(clk, rst, reg11,reg12,reg13,o1,o2,o3);

endmodule
