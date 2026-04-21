`timescale 1ns / 1ps

module ALU_1bit(
    input A,
    input B,
    input cin,
    input [3:0] ALUControl,
    output reg ALUResult,
    output cout
);

    wire binvert;
    wire sum_out;
    
    assign binvert = (ALUControl == 4'b0110 || ALUControl == 4'b0111) ? ~B : B;

    fullAdder addSubtract(
        .a(A),
        .b(binvert),
        .cin(cin),
        .sum(sum_out),
        .cout(cout)
    );

    always@(*) begin
        case(ALUControl)
            4'b0000: ALUResult = A & B;
            4'b0001: ALUResult = A | B;
            4'b0010: ALUResult = sum_out;
            4'b0110: ALUResult = sum_out;
            4'b0101: ALUResult = A ^ B;
            default: ALUResult = 1'b0;
        endcase
    end

endmodule