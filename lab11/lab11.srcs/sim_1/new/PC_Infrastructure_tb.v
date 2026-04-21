`timescale 1ns/1ps
module PC_Infrastructure_tb();
reg clk;
reg rst;
reg PCSrc;
reg [31:0] instruction;
wire [31:0] PC, PCPlus4, imm, BranchTarget, PCNext;

ProgramCounter u_PC (.clk(clk), .rst(rst), .PCNext(PCNext), .PC(PC));
pcAdder u_pcAdd (.PC(PC), .PCPlus4(PCPlus4));
immGen u_immGen (.instruction(instruction), .imm(imm));
branch_adder u_brAdd (.PC(PC), .imm(imm), .BranchTarget(BranchTarget));
mmux2 u_pcmux (.in0(PCPlus4), .in1(BranchTarget), .sel(PCSrc), .out(PCNext));

always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;
    PCSrc = 0;
    instruction = 32'd0;
    #10;
    rst = 0; 
    
    #10;
    #10;
    
    instruction = 32'hfff28293;
    #10;
    
    
    instruction = 32'hfe000ce3;
    PCSrc = 1; 
    #10;
    PCSrc = 0;
    #10;
    
    $finish;
end
endmodule