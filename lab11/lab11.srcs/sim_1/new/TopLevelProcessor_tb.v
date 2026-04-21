`timescale 1ns/1ps

module TopLevelProcessor_tb();

    reg clk;
    reg rst;
    
    wire [31:0] out_PC;
    wire [31:0] out_ALUResult;

    TopLevelProcessor uut (
        .clk(clk),
        .rst(rst),
        .out_PC(out_PC),
        .out_ALUResult(out_ALUResult)
    );

    always #10 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        #25;
        rst = 0;
        #1000;
        $finish;
    end

    initial begin
        $monitor("Time=%0t ns | rst=%b | PC=%h | ALUResult=%h", $time, rst, out_PC, out_ALUResult);
    end

endmodule