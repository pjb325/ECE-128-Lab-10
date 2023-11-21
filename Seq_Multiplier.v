`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2023 02:02:44 PM
// Design Name: 
// Module Name: Seq_Multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Seq_Multiplier(input clk, input rst, input P1, input P2, output reg z);

    parameter S0_idle = 0 , S1_multiply = 1 , S2_update_result = 2 ;
    reg [2:0] CS,NS;
  
    always @(posedge clk)
    begin
        if(rst==1) 
            CS <= 3'b000;// when reset=1, reset the CS of the FSM to "S0" CS
         else
            CS <= NS; // otherwise, next CS
    end 
    
    
    always@(CS,rst)
    begin
        S0_idle: begin
            partial_product <= 8'b0;
            shift_count <= 3'b0;
            mulyiplicand <= (4'b0, operand_a);
            operand_bb <= operand_b;
            NS = S1_multiply;
        S1_multiply: begin
        NS = S2_update_result;
            if((operand_bb[0] == 0 && shift_count < 4)) begin
                partial_product <= partial_product;
                shift_count <= shift_count + 3'b1;
                multiplicand <= multiplicand <<1;
                operand_bb <= operand_bb>>1;
            else if ((operand_bb[0] == 1 && shift_count < 4)) begin
                partial_product <= partial_product + multiplicand;
                shift_count <= shift_count + 3'b1;
                multiplicand <= multiplicand <<1;
                operand_bb <= operand_bb>>1;
            end

    end
    
    S2_update_result: begin
        if(shift_count ==4) begin
        NS = S2_update_result;
        product <= partial_product;
        end
        else begin
        NS = S1_multiply;
        end
        end
endmodule
