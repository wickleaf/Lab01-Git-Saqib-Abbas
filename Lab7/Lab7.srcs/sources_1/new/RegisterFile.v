`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2026 02:50:15 PM
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile (
    input wire clk,
    input wire rst,
    input wire WriteEnable,
    input wire [4:0] rs1,
    input wire [4:0] rs2,
    input wire [4:0] rd,
    input wire [31:0] WriteData,
    output wire [31:0] ReadData1,
    output wire [31:0] readData2
);

    reg [31:0] regs [31:0];
    
    integer i;

    assign ReadData1 = (rs1 == 5'd0) ? 32'b0 : regs[rs1];
    assign readData2 = (rs2 == 5'd0) ? 32'b0 : regs[rs2];

    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1) begin
                regs[i] <= 32'b0;
            end
        end 
        else if (WriteEnable && (rd != 5'd0)) begin
            regs[rd] <= WriteData;
        end
    end

endmodule