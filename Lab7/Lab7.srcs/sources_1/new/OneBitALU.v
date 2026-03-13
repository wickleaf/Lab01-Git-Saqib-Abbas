`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2026 09:48:47 PM
// Design Name: 
// Module Name: OneBitALU
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


module ALU_1bit(
    input A,
    input B,
    input cin,
    input [3:0] ALUControl,
    output reg ALUResult,
    output cout
    );
        
    wire binvert;
    wire sumOut;
    
    assign binvert = (ALUControl == 4'b0010) ? ~B : B;
    
    fullAdder addSubtract(
        .a(A),
        .b(binvert),
        .cin(cin),
        .sum(sum_out),
        .cout(cout)
    );
    always@(*) begin
        case(ALUControl)
            4'b0001: ALUResult = sum_out;
            4'b0010: ALUResult = sum_out;
            4'b0011: ALUResult = A & B;
            4'b0100: ALUResult = A | B;
            4'b0101: ALUResult = A ^ B;
            default: ALUResult = 1'b0;
        endcase
    end
endmodule
