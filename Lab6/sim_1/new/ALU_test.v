`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2026 10:18:00 PM
// Design Name: 
// Module Name: ALU_test
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


module ALU_test(
    );
    reg [31:0] a;
    reg [31:0] b;
    reg [3:0] alu_ctrl;

    wire [31:0] result;
    wire zero;

    ALU_top uut (
        .A(a),
        .B(b),
        .ALUControl(alu_ctrl),
        .ALUResult(result),
        .zero(zero)
    );

    initial begin

        //ADD (15 + 10 = 25)
        a = 32'd15; b = 32'd10; alu_ctrl = 4'b0001; 
        #10;

        //SUB (25 - 10 = 15)
        a = 32'd25; b = 32'd10; alu_ctrl = 4'b0010; 
        #10;

        //AND (Bitwise 1100 & 1010 = 1000)
        a = 32'b1100; b = 32'b1010; alu_ctrl = 4'b0011; 
        #10;

        //OR (Bitwise 1100 | 1010 = 1110)
        a = 32'b1100; b = 32'b1010; alu_ctrl = 4'b0100; 
        #10;

        //XOR (Bitwise 1100 ^ 1010 = 0110)
        a = 32'b1100; b = 32'b1010; alu_ctrl = 4'b0101; 
        #10;

        //SLL (Shift Left Logical: 1 shifted left by 3 = 8)
        a = 32'd1; b = 32'd3; alu_ctrl = 4'b0110;
        #10;

        //SRL (Shift Right Logical: 16 shifted right by 2 = 4)
        a = 32'd16; b = 32'd2; alu_ctrl = 4'b0111;
        #10;
        
        //Zero flag test
        a = 32'd42; b = 32'd42; alu_ctrl = 4'b0010;
        #10;

    end

endmodule
