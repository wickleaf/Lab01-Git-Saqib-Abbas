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

// Clock Generation
always #5 clk = ~clk;

initial begin
    // Initialize
    clk = 0;
    rst = 1;
    PCSrc = 0;
    instruction = 32'd0;
    #10;
    rst = 0; // Release reset, PC should be 0
    
    // TEST 1: Sequential PC+4 updates
    #10; // PC becomes 4
    #10; // PC becomes 8
    
    // TEST 2: I-Type Immediate Generation (ADDI x5, x5, -1) -> 0xfff28293
    instruction = 32'hfff28293;
    #10; // PC becomes 12. imm should be 0xFFFFFFFF (-1)
    
    // TEST 3: Branch Target Update (BEQ - Branch backward by -4 bytes)
    // BEQ instruction generating an unshifted -2 offset.
    // immGen should output 0xFFFFFFFE (-2). branch_adder shifts to -4.
    instruction = 32'hfe000ce3;
    PCSrc = 1; // Trigger the branch
    #10; // PC should update to (12-4)=8
    PCSrc = 0;
    #10; // PC becomes 12 again
    
    $finish;
end
endmodule