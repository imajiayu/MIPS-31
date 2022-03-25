`timescale 1ns / 1ps

module id_stall(
    input clk,
    input rst,
    input [5:0] op,  
    input [5:0] func,
    input [4:0] rs,
    input [4:0] rt,
    input rf_rena1,
    input rf_rena2,

    // Data from EXE  
	input [4:0] exe_rf_waddr,  
    input exe_rf_wena,

	// Data from MEM
	input [4:0] mem_rf_waddr,  
    input mem_rf_wena,

    output reg stall
    );

    reg counter;
    
    // Data hazard judge for ID and EXE and MEM
    always @ (negedge clk or posedge rst) 
    begin
        if(rst == `RST_ENABLED) begin
            stall <= `RUN;
            counter <= 0;
        end

        else if(counter >= 1) begin
            counter <= counter - 1;
        end

        else if(stall == `STOP) begin
            stall <= `RUN;            
        end

        else if(stall == `RUN) begin
            // Rs and Rt
                // EXE Rs
                if(exe_rf_wena == `WRITE_ENABLED && rf_rena1 == `READ_ENABLED && exe_rf_waddr == rs) begin
                    counter <= 1'b1;
                    stall <= `STOP;
                end
                // MEM Rs
                else if(mem_rf_wena == `WRITE_ENABLED && rf_rena1 == `READ_ENABLED && mem_rf_waddr == rs) begin
                    stall <= `STOP;
                end

                // EXE Rt
                if(exe_rf_wena == `WRITE_ENABLED && rf_rena2 == `READ_ENABLED && exe_rf_waddr == rt) begin
                    counter <= 1'b1;
                    stall <= `STOP;
                end
                // MEM Rt
                else if(mem_rf_wena == `WRITE_ENABLED && rf_rena2 == `READ_ENABLED && mem_rf_waddr == rt) begin
                    stall <= `STOP;
                end
            end
        end    


endmodule
