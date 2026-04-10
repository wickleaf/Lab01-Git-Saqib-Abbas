`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Lab 7 - Task 2 (c): Integrated FSM Testbench  (RF_ALU_FSM_tb.v)
// Instantiates ALU_top + RegisterFile and drives them with an FSM that:
//   i.   Writes known constants into x1, x2, x3
//   ii.  Reads x1/x2 (or x1/x3), feeds the ALU, writes results to x4-x10
//   iii. BEQ-style check via ALU Zero flag -> conditionally writes x11
//   iv.  Read-after-write timing test on x12
////////////////////////////////////////////////////////////////////////////////

module Integrated_FSM_tb;

    reg clk, rst;
    initial clk = 0;
    always #5 clk = ~clk;          // 100 MHz

    reg        WriteEnable;
    reg  [4:0] rs1, rs2, rd;
    reg [31:0] WriteData;

    reg [3:0] ALUControl;

    wire [31:0] ReadData1, ReadData2;
    wire [31:0] ALUResult;
    wire        zero;

    RegisterFile uut_rf (
        .clk        (clk),
        .rst        (rst),
        .WriteEnable(WriteEnable),
        .rs1        (rs1),
        .rs2        (rs2),
        .rd         (rd),
        .WriteData  (WriteData),
        .ReadData1  (ReadData1),
        .readData2  (ReadData2)
    );

    ALU_top uut_alu (
        .A         (ReadData1),
        .B         (ReadData2),
        .ALUControl(ALUControl),
        .ALUResult (ALUResult),
        .zero      (zero)
    );
    localparam [4:0]
        IDLE       = 5'd0,
        WR_X1      = 5'd1,
        WR_X2      = 5'd2,
        WR_X3      = 5'd3,
        EXEC_ADD   = 5'd4,   WBACK_ADD = 5'd5,
        EXEC_SUB   = 5'd6,   WBACK_SUB = 5'd7,
        EXEC_AND   = 5'd8,   WBACK_AND = 5'd9,
        EXEC_OR    = 5'd10,  WBACK_OR  = 5'd11,
        EXEC_XOR   = 5'd12,  WBACK_XOR = 5'd13,
        EXEC_SLL   = 5'd14,  WBACK_SLL = 5'd15,
        EXEC_SRL   = 5'd16,  WBACK_SRL = 5'd17,
        BEQ_EXEC   = 5'd18,  BEQ_FLAG  = 5'd19,
        RAW_WRITE  = 5'd20,  RAW_READ  = 5'd21,
        DONE       = 5'd22;

    localparam [3:0]
        CTRL_ADD = 4'b0001,
        CTRL_SUB = 4'b0010,
        CTRL_AND = 4'b0011,
        CTRL_OR  = 4'b0100,
        CTRL_XOR = 4'b0101,
        CTRL_SLL = 4'b0110,
        CTRL_SRL = 4'b0111;

    reg [4:0] state;
    reg [4:0] next_state;
    
    always @(posedge clk) begin
        if (rst) state <= IDLE;
        else     state <= next_state;
    end


    always @(*) begin
        WriteEnable = 1'b0;
        WriteData   = 32'd0;
        rd          = 5'd0;
        rs1         = 5'd0;
        rs2         = 5'd0;
        ALUControl  = CTRL_ADD;
        next_state  = state;

        case (state)
            IDLE:     next_state = WR_X1;

            WR_X1: begin
                WriteEnable = 1; rd = 5'd1; WriteData = 32'h10101010;
                next_state = WR_X2;
            end
            WR_X2: begin
                WriteEnable = 1; rd = 5'd2; WriteData = 32'h01010101;
                next_state = WR_X3;
            end
            WR_X3: begin
                WriteEnable = 1; rd = 5'd3; WriteData = 32'h00000005;
                next_state = EXEC_ADD;
            end

            EXEC_ADD: begin
                rs1 = 5'd1; rs2 = 5'd2; ALUControl = CTRL_ADD;
                next_state = WBACK_ADD;
            end
            WBACK_ADD: begin
                WriteEnable = 1; rd = 5'd4; WriteData = ALUResult;
                rs1 = 5'd1; rs2 = 5'd2; ALUControl = CTRL_ADD;
                next_state = EXEC_SUB;
            end

            EXEC_SUB: begin
                rs1 = 5'd1; rs2 = 5'd2; ALUControl = CTRL_SUB;
                next_state = WBACK_SUB;
            end
            WBACK_SUB: begin
                WriteEnable = 1; rd = 5'd5; WriteData = ALUResult;
                rs1 = 5'd1; rs2 = 5'd2; ALUControl = CTRL_SUB;
                next_state = EXEC_AND;
            end

            EXEC_AND: begin
                rs1 = 5'd1; rs2 = 5'd2; ALUControl = CTRL_AND;
                next_state = WBACK_AND;
            end
            WBACK_AND: begin
                WriteEnable = 1; rd = 5'd6; WriteData = ALUResult;
                rs1 = 5'd1; rs2 = 5'd2; ALUControl = CTRL_AND;
                next_state = EXEC_OR;
            end

            EXEC_OR: begin
                rs1 = 5'd1; rs2 = 5'd2; ALUControl = CTRL_OR;
                next_state = WBACK_OR;
            end
            WBACK_OR: begin
                WriteEnable = 1; rd = 5'd7; WriteData = ALUResult;
                rs1 = 5'd1; rs2 = 5'd2; ALUControl = CTRL_OR;
                next_state = EXEC_XOR;
            end

            EXEC_XOR: begin
                rs1 = 5'd1; rs2 = 5'd2; ALUControl = CTRL_XOR;
                next_state = WBACK_XOR;
            end
            WBACK_XOR: begin
                WriteEnable = 1; rd = 5'd8; WriteData = ALUResult;
                rs1 = 5'd1; rs2 = 5'd2; ALUControl = CTRL_XOR;
                next_state = EXEC_SLL;
            end

            EXEC_SLL: begin
                rs1 = 5'd1; rs2 = 5'd3; ALUControl = CTRL_SLL;
                next_state = WBACK_SLL;
            end
            WBACK_SLL: begin
                WriteEnable = 1; rd = 5'd9; WriteData = ALUResult;
                rs1 = 5'd1; rs2 = 5'd3; ALUControl = CTRL_SLL;
                next_state = EXEC_SRL;
            end

            EXEC_SRL: begin
                rs1 = 5'd1; rs2 = 5'd3; ALUControl = CTRL_SRL;
                next_state = WBACK_SRL;
            end
            WBACK_SRL: begin
                WriteEnable = 1; rd = 5'd10; WriteData = ALUResult;
                rs1 = 5'd1; rs2 = 5'd3; ALUControl = CTRL_SRL;
                next_state = BEQ_EXEC;
            end

            BEQ_EXEC: begin
                rs1 = 5'd1; rs2 = 5'd1; ALUControl = CTRL_SUB;
                next_state = BEQ_FLAG;
            end
            BEQ_FLAG: begin
                rs1 = 5'd1; rs2 = 5'd1; ALUControl = CTRL_SUB;
                if (zero) begin
                    WriteEnable = 1; rd = 5'd11; WriteData = 32'h00000001;
                end
                next_state = RAW_WRITE;
            end

            RAW_WRITE: begin
                WriteEnable = 1; rd = 5'd12; WriteData = 32'hCAFEBABE;
                next_state = RAW_READ;
            end
            RAW_READ: begin
                rs1 = 5'd12;
                next_state = DONE;
            end

            DONE:    next_state = DONE;
            default: next_state = IDLE;
        endcase
    end
    
    initial begin
        state = IDLE;
        rst = 1;
        @(posedge clk);
        @(posedge clk);
        rst = 0;
        repeat(30) @(posedge clk);
        $finish;
    end
endmodule
