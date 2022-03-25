`timescale 1ns / 1ns

module seg7x16(
    input clk,
	input reset,
	input [31:0] i_data1,
	input [31:0] i_data2,
	input [31:0] i_data3,
	output reg [7:0] oData1,
	output reg [7:0] oData2,
	output reg [7:0] oData3
    );
    reg [31:0] data1;
    reg [31:0] data2;
    reg [31:0] data3;
    always @(posedge clk, posedge reset)
    begin
        if(reset)
        begin
            data1<=32'h0;
            data2<=32'h0;
            data3<=32'h0;
        end
        else
        begin
            data1<=i_data1;
            data2<=i_data2;
            data3<=i_data3;
        end
    end
    
       always @(posedge clk)
            case(data1[3:0])
            4'b0000:oData1=7'b1000000;
            4'b0001:oData1=7'b1111001;
            4'b0010:oData1=7'b0100100;
            4'b0011:oData1=7'b0110000;
            4'b0100:oData1=7'b0011001;
            4'b0101:oData1=7'b0010010;
            4'b0110:oData1=7'b0000010;
            4'b0111:oData1=7'b1111000;
            4'b1000:oData1=7'b0000000;
            4'b1001:oData1=7'b0010000;
            endcase
        
        always @(posedge clk)
        case(data2[3:0])
        4'b0000:oData2=7'b1000000;
        4'b0001:oData2=7'b1111001;
        4'b0010:oData2=7'b0100100;
        4'b0011:oData2=7'b0110000;
        4'b0100:oData2=7'b0011001;
        4'b0101:oData2=7'b0010010;
        4'b0110:oData2=7'b0000010;
        4'b0111:oData2=7'b1111000;
        4'b1000:oData2=7'b0000000;
        4'b1001:oData2=7'b0010000;
        endcase
        
        always @(posedge clk)
        case(data3[3:0])
        4'b0000:oData3=7'b1000000;
        4'b0001:oData3=7'b1111001;
        4'b0010:oData3=7'b0100100;
        4'b0011:oData3=7'b0110000;
        4'b0100:oData3=7'b0011001;
        4'b0101:oData3=7'b0010010;
        4'b0110:oData3=7'b0000010;
        4'b0111:oData3=7'b1111000;
        4'b1000:oData3=7'b0000000;
        4'b1001:oData3=7'b0010000;
        endcase
            
endmodule
