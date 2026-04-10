`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2026 09:36:19 AM
// Design Name: 
// Module Name: RegisterFile_tb
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


`timescale 1ns / 1ps

module RegisterFile_tb;

    reg clk;
    reg rst;
    reg WriteEnable;
    reg [4:0] rs1;
    reg [4:0] rs2;
    reg [4:0] rd;
    reg [31:0] WriteData;

    wire [31:0] ReadData1;
    wire [31:0] readData2;

    RegisterFile uut (
        .clk(clk),
        .rst(rst),
        .WriteEnable(WriteEnable),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .readData2(readData2)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 0;
        WriteEnable = 0;
        rs1 = 0;
        rs2 = 0;
        rd = 0;
        WriteData = 0;

        rst = 1;
        #10;
        rst = 0;
        
        rd = 5'd5;
        WriteData = 32'hDEADBEEF;
        WriteEnable = 1;
        #10;
        WriteEnable = 0;
        
        rs1 = 5'd5;
        #5;

        rd = 5'd0;
        WriteData = 32'hBADCAFE0;
        WriteEnable = 1;
        #10;
        WriteEnable = 0;

        rs2 = 5'd0;
        #5;

        rd = 5'd10;
        WriteData = 32'h12345678;
        WriteEnable = 1;
        #10;
        WriteEnable = 0;

        rs1 = 5'd5;
        rs2 = 5'd10;
        #5;

        rd = 5'd5;
        WriteData = 32'h0000BEEF;
        WriteEnable = 1;
        #10;
        WriteEnable = 0;

        rs1 = 5'd5;
        #5;

        rst = 1;
        #10;
        rst = 0;
        
        rs1 = 5'd5;
        rs2 = 5'd10;
        #5;
        $finish;
    end

endmodule
