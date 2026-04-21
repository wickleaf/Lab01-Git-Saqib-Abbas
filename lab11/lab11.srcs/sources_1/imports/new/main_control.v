`timescale 1ns / 1ps

module main_control (
    input  wire [6:0] opcode,
    output reg        RegWrite,
    output reg [1:0]  ALUOp,
    output reg        MemRead,
    output reg        MemWrite,
    output reg        ALUSrc,
    output reg        MemtoReg,
    output reg        Branch
);

    localparam R_TYPE  = 7'b0110011;
    localparam I_ALU   = 7'b0010011;
    localparam LOAD    = 7'b0000011;
    localparam STORE   = 7'b0100011;
    localparam BRANCH  = 7'b1100011;

    always @(*) begin
        RegWrite = 1'b0;
        ALUOp    = 2'b00;
        MemRead  = 1'b0;
        MemWrite = 1'b0;
        ALUSrc   = 1'b0;
        MemtoReg = 1'b0;
        Branch   = 1'b0;

        case (opcode)
            R_TYPE: begin
                RegWrite = 1'b1;
                ALUOp    = 2'b10;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                ALUSrc   = 1'b0;
                MemtoReg = 1'b0;
                Branch   = 1'b0;
            end
            I_ALU: begin
                RegWrite = 1'b1;
                ALUOp    = 2'b10;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                ALUSrc   = 1'b1;
                MemtoReg = 1'b0;
                Branch   = 1'b0;
            end
            LOAD: begin
                RegWrite = 1'b1;
                ALUOp    = 2'b00;
                MemRead  = 1'b1;
                MemWrite = 1'b0;
                ALUSrc   = 1'b1;
                MemtoReg = 1'b1;
                Branch   = 1'b0;
            end
            STORE: begin
                RegWrite = 1'b0;
                ALUOp    = 2'b00;
                MemRead  = 1'b0;
                MemWrite = 1'b1;
                ALUSrc   = 1'b1;
                MemtoReg = 1'bx;
                Branch   = 1'b0;
            end
            BRANCH: begin
                RegWrite = 1'b0;
                ALUOp    = 2'b01;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                ALUSrc   = 1'b0;
                MemtoReg = 1'bx;
                Branch   = 1'b1;
            end
            default: begin
                RegWrite = 1'b0;
                ALUOp    = 2'b00;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                ALUSrc   = 1'b0;
                MemtoReg = 1'b0;
                Branch   = 1'b0;
            end
        endcase
    end

endmodule