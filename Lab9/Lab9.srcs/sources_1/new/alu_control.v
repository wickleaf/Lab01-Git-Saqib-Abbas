`timescale 1ns / 1ps

module alu_control (
    input  wire [1:0] ALUOp,
    input  wire [2:0] funct3,
    input  wire [6:0] funct7,
    output reg  [3:0] ALUControl
);

    localparam F3_ADD_SUB = 3'b000;
    localparam F3_SLL     = 3'b001;
    localparam F3_SLT     = 3'b010;
    localparam F3_SLTU    = 3'b011;
    localparam F3_XOR     = 3'b100;
    localparam F3_SRL_SRA = 3'b101;
    localparam F3_OR      = 3'b110;
    localparam F3_AND     = 3'b111;

    always @(*) begin
        ALUControl = 4'b0010; 

        case (ALUOp)
            
            2'b00: begin
                ALUControl = 4'b0010;
            end

            2'b01: begin
                ALUControl = 4'b0110;
            end

            2'b10: begin
                case (funct3)
                    F3_ADD_SUB: begin
                        if (funct7[5] == 1'b1)
                            ALUControl = 4'b0110;
                        else
                            ALUControl = 4'b0010;
                    end

                    F3_AND: begin
                        ALUControl = 4'b0000;
                    end

                    F3_OR: begin
                        ALUControl = 4'b0001;
                    end

                    F3_SLT: begin
                        ALUControl = 4'b0111;
                    end

                    default: begin
                        ALUControl = 4'b0010;
                    end
                endcase
            end

            default: begin
                ALUControl = 4'b0010;
            end
        endcase
    end

endmodule