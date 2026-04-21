`timescale 1ns/1ps

module TopLevelProcessor(
    input wire clk,
    input wire rst,
    output wire [31:0] out_PC,
    output wire [31:0] out_ALUResult
);

wire [31:0] PC, PCNext, PCPlus4;
wire [31:0] instruction;

wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
wire [1:0] ALUOp;
wire [3:0] ALU_Ctrl_Signal;
wire PCSrc;

wire [31:0] imm;
wire [31:0] readData1, readData2, WriteData;

wire [31:0] ALU_B, ALUResult;
wire Zero;

wire [31:0] mem_read_data;
wire [31:0] BranchTarget;

assign out_PC = PC;
assign out_ALUResult = ALUResult;

ProgramCounter u_PC (
    .clk(clk),
    .rst(rst),
    .PCNext(PCNext),
    .PC(PC)
);

pcAdder u_pcAdd (
    .PC(PC),
    .PCPlus4(PCPlus4)
);

instructionMemory u_InstMem (
    .instAddress(PC),
    .instruction(instruction)
);

main_control u_MainControl (
    .opcode(instruction[6:0]),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .ALUOp(ALUOp),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite)
);

RegisterFile u_RegFile (
    .clk(clk),
    .rst(rst),
    .WriteEnable(RegWrite),
    .rs1(instruction[19:15]),
    .rs2(instruction[24:20]),
    .rd(instruction[11:7]),
    .WriteData(WriteData),
    .ReadData1(readData1),
    .readData2(readData2)
);

immGen u_immGen (
    .instruction(instruction),
    .imm(imm)
);

alu_control u_ALUControl (
    .ALUOp(ALUOp),
    .funct3(instruction[14:12]),
    .funct7(instruction[31:25]),
    .ALUControl(ALU_Ctrl_Signal)
);

mmux2 u_ALUSrcMux (
    .in0(readData2),
    .in1(imm),
    .sel(ALUSrc),
    .out(ALU_B)
);

ALU_top u_ALU (
    .A(readData1),
    .B(ALU_B),
    .ALUControl(ALU_Ctrl_Signal),
    .ALUResult(ALUResult),
    .zero(Zero)
);

branch_adder u_brAdd (
    .PC(PC),
    .imm(imm),
    .BranchTarget(BranchTarget)
);

assign PCSrc = Branch & Zero;

mmux2 u_PCMux (
    .in0(PCPlus4),
    .in1(BranchTarget),
    .sel(PCSrc),
    .out(PCNext)
);

DataMemory u_DataMem (
    .clk(clk),
    .rst(rst),
    .memWrite(MemWrite),
    .address(ALUResult[8:2]),
    .writeData(readData2),
    .readData(mem_read_data)
);

mmux2 u_MemtoRegMux (
    .in0(ALUResult),
    .in1(mem_read_data),
    .sel(MemtoReg),
    .out(WriteData)
);

endmodule