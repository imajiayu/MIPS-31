//名称：算数逻辑单元
//input：a(输入端A)
//       b(输入端B)
//       aluc(4位控制信号)
//output:r(运算结果输出)
//       zero(零标志位)
//       carry(进位表示位)
//       negative()
//       overflow(溢出标志位)

module ALU(a,b,aluc,r,zero,carry,negative,overflow);
    input [31:0] a;
    input [31:0] b;
    input [3:0] aluc;
    output reg [31:0] r;
    output reg zero=1'b0;
    output reg carry=1'b0;
    output reg negative=1'b0;
    output reg overflow=1'b0;

    reg [32:0] unSsum;
    reg signed [31:0] Sa;
    reg signed [31:0] Sb;
    reg signed [32:0] Ssum;
    reg signed [32:0] StempSub;
    
    always @(a or b or aluc) 
    begin
        zero=1'b0;
        carry=1'b0;
        negative=1'b0;
        overflow=1'b0;

        Ssum=33'b000000000000000000000000000000000;
        unSsum=33'b000000000000000000000000000000000;
        Sa=$signed(a);
        Sb=$signed(b);
        StempSub=32'b00000000000000000000000000000000;
        case(aluc)
            4'b0000://ADDU
            begin
                unSsum=a+b;
                r=unSsum[31:0];
                if(r==32'h00000000)
                    zero=1'b1;
                else zero=1'b0;
                if(unSsum[32])
                    carry=1'b1;
                else carry=1'b0;
                if(r[31])
                    negative=1'b1;
                else negative=1'b0;
            end
            4'b0010://ADD
            begin
                Ssum=Sa+Sb;
                r=Ssum[31:0];
                if(r==32'h00000000)
                    zero=1'b1;
                else zero=1'b0;
                if(r[31])
                    negative=1'b1;
                else negative=1'b0;
                if(Ssum[32]!=Ssum[31])
                    overflow=1'b1;
                else overflow=1'b0;
            end
            4'b0001://SUBU
            begin
                unSsum=a-b;
                r=unSsum[31:0];
                if(r==32'h00000000)
                    zero=1'b1;
                else zero=1'b0;
                if(unSsum[32])
                    carry=1'b1;
                else carry=1'b0;
                if(r[31])
                    negative=1'b1;
                else negative=1'b0;
            end
            4'b0011://SUB
            begin
                Ssum=Sa-Sb;
                r=Ssum[31:0];
                if(r==32'h00000000)
                    zero=1'b1;
                else zero=1'b0;
                if(r[31])
                    negative=1'b1;
                else negative=1'b0;
                if(Ssum[32]!=Ssum[31])
                    overflow=1'b1;
                else overflow=1'b0;
            end
            4'b0100://AND
            begin
                r=a&b;
                if(r==32'h00000000)
                    zero=1'b1;
                else zero=1'b0;
                if(r[31])
                    negative=1'b1;
                else negative=1'b0;
            end
            4'b0101://OR
            begin
                r=a|b;
                if(r==32'h00000000)
                    zero=1'b1;
                else zero=1'b0;
                if(r[31])
                    negative=1'b1;
                else negative=1'b0;
            end
            4'b0110://XOR
            begin
                r=a^b;
                if(r==32'h00000000)
                    zero=1'b1;
                else zero=1'b0;
                if(r[31])
                    negative=1'b1;
                else negative=1'b0;
            end
            4'b0111://NOR
            begin
                r=~(a|b);
                if(r==32'h00000000)
                    zero=1'b1;
                else zero=1'b0;
                if(r[31])
                    negative=1'b1;
                else negative=1'b0;
            end
            4'b1000,4'b1001://LUI
            begin
                r={b[15:0],16'b0000000000000000};
                if(r==32'h00000000)
                    zero=1'b1;
                else zero=1'b0;
                if(r[31])
                    negative=1'b1;
                else negative=1'b0;
            end
            4'b1011://SLT
            begin
                r=(Sa<Sb)?32'h00000001:32'h00000000;
                if(Sa==Sb)
                    zero=1'b1;
                else zero=1'b0;
                StempSub=Sa+(~Sb+1'b1);
                if(StempSub[31])
                    negative=1'b1;
                else negative=1'b0;
            end
            4'b1010://SLTU
            begin
                r=(a<b)?32'h00000001:32'h00000000;
                if(a==b)
                    zero=1'b1;
                else zero=1'b0;
                if(a<b)
                    carry=1'b1;
                else carry=1'b0;
                if(r[31])
                    negative=1'b1;
                else negative=1'b0;
            end
            4'b1100://SRA
            begin
                r=Sb>>>a;
                if(r==32'h00000000)
                    zero=1'b1;
                else zero=1'b0;
                if(a==32'h00000000)
                    carry=carry;
                else if(a<=32)
                    carry=b[a-1];
                else carry=b[31];
                if(r[31])
                    negative=1'b1;
                else negative=1'b0;
            end
            4'b1110,4'b1111://SLL/SLA
            begin
                r=b<<a;
                if(r==32'h00000000)
                    zero=1'b1;
                else zero=1'b0;
                if(a==32'h00000000)
                    carry=1'b0;
                else if(a<=32)
                    carry=b[32-a];
                else carry=1'b0;
                if(r[31])
                    negative=1'b1;
                else negative=1'b0;
            end
            4'b1101://SRL
            begin
                r=b>>a;
                if(r==32'h00000000)
                    zero=1'b1;
                else zero=1'b0;
                if(a==32'h00000000)
                    carry=carry;
                else if(a<=32)
                    carry=b[a-1];
                else carry=1'b0;
                if(r[31])
                    negative=1'b1;
                else negative=1'b0;
            end
            default:
                begin
                end
        endcase
    end

    

endmodule