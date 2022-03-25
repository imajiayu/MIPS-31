`timescale 1ns / 1ps

module CPU_tb();
  reg clk;
  reg reset;
  integer file_output;
  integer counter=0;
  
  cpu_top uut (clk, reset); 
  
  initial
    begin 
      file_output = $fopen("C:\\Users\\Lenovo\\OneDrive\\SS\\MIPS31_SP\\myresult.txt");
      clk=0;
      reset=1;
      #50;
      reset=0;
    end
  always
    begin
      #50;
      clk=~clk;
      if(counter==4000)  
        begin
          $fclose(file_output);
        end
      else if(clk==1'b1)
        begin
          counter<=counter+1;
          /*
          $fdisplay(file_output,"mycount = %h",CPU_tb.counter);
          $fdisplay(file_output,"mypc = %h", CPU_tb.uut.pc);
          $fdisplay(file_output,"myinstr = %h", CPU_tb.uut.instruction);
        
          $fdisplay(file_output,"regfiles0  = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[0]);
          $fdisplay(file_output,"regfiles1  = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[1]);
          $fdisplay(file_output,"regfiles2  = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[2]);
          $fdisplay(file_output,"regfiles3  = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[3]);
          $fdisplay(file_output,"regfiles4  = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[4]);
          $fdisplay(file_output,"regfiles5  = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[5]);
          $fdisplay(file_output,"regfiles6  = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[6]);
          $fdisplay(file_output,"regfiles7  = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[7]);
          $fdisplay(file_output,"regfiles8  = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[8]);
          $fdisplay(file_output,"regfiles9  = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[9]);
          $fdisplay(file_output,"regfiles10 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[10]);
          $fdisplay(file_output,"regfiles11 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[11]);
          $fdisplay(file_output,"regfiles12 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[12]);
          $fdisplay(file_output,"regfiles13 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[13]);
          $fdisplay(file_output,"regfiles14 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[14]);
          $fdisplay(file_output,"regfiles15 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[15]);
          $fdisplay(file_output,"regfiles16 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[16]);
          $fdisplay(file_output,"regfiles17 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[17]);
          $fdisplay(file_output,"regfiles18 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[18]);
          $fdisplay(file_output,"regfiles19 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[19]);
          $fdisplay(file_output,"regfiles20 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[20]);
          $fdisplay(file_output,"regfiles21 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[21]);
          $fdisplay(file_output,"regfiles22 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[22]);
          $fdisplay(file_output,"regfiles23 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[23]);
          $fdisplay(file_output,"regfiles24 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[24]);
          $fdisplay(file_output,"regfiles25 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[25]);
          $fdisplay(file_output,"regfiles26 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[26]);
          $fdisplay(file_output,"regfiles27 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[27]);
          $fdisplay(file_output,"regfiles28 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[28]);
          $fdisplay(file_output,"regfiles29 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[29]);
          $fdisplay(file_output,"regfiles30 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[30]);
          $fdisplay(file_output,"regfiles31 = %h", CPU_tb.uut.instruction_decoder.cpu_regfile.regs[31]);
          */
        end     
    end
endmodule