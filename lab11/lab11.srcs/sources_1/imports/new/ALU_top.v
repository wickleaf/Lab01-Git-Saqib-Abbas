`timescale 1ns / 1ps

module ALU_top (
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALUControl,
    output reg [31:0] ALUResult,
    output zero
);

    wire [32:0] carry;
    wire [31:0] temp_res;
    
    assign carry[0] = (ALUControl == 4'b0110 || ALUControl == 4'b0111) ? 1'b1 : 1'b0;

    genvar i;

    generate
        for (i = 0; i < 32; i = i + 1) begin : alu_slice
            ALU_1bit alu_inst (
                .A(A[i]),
                .B(B[i]),
                .cin(carry[i]),
                .ALUControl(ALUControl),
                .ALUResult(temp_res[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate

    always@(*) begin
        case(ALUControl)
            4'b0111: ALUResult = {31'd0, temp_res[31]};
            4'b1000: ALUResult = A << B[4:0];
            4'b1001: ALUResult = A >> B[4:0];
            default: ALUResult = temp_res;
        endcase
    end   

    assign zero = (ALUResult == 32'b0) ? 1'b1 : 1'b0;

endmodule