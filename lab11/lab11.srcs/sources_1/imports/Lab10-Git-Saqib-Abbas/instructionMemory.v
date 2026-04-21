`timescale 1ns/1ps

module instructionMemory #(
    parameter OPERAND_LENGTH = 31
)(
    input  [OPERAND_LENGTH:0] instAddress,
    output [31:0] instruction
);

    reg [31:0] rom [0:33];

    initial begin
        rom[0]  = 32'h1F000113;
        rom[1]  = 32'h20000493;
        rom[2]  = 32'h30000913;
        rom[3]  = 32'h30400993;
        rom[4]  = 32'h0004A023;
        rom[5]  = 32'h00092503;
        rom[6]  = 32'hFE050EE3;
        rom[7]  = 32'h00C000EF;
        rom[8]  = 32'hFF1FF06F;
        rom[9]  = 32'hFF810113;
        rom[10] = 32'h00112223;
        rom[11] = 32'h00812023;
        rom[12] = 32'h00050413;
        rom[13] = 32'h02040263;
        rom[14] = 32'h0009A283;
        rom[15] = 32'h00029A63;
        rom[16] = 32'h0084A023;
        rom[17] = 32'h024000EF;
        rom[18] = 32'hFFF40413;
        rom[19] = 32'hFE9FF06F;
        rom[20] = 32'h0004A023;
        rom[21] = 32'h0080006F;
        rom[22] = 32'h0004A023;
        rom[23] = 32'h00412083;
        rom[24] = 32'h00012403;
        rom[25] = 32'h00810113;
        rom[26] = 32'h00008067;
        rom[27] = 32'h3E800313;
        rom[28] = 32'h1F400393;
        rom[29] = 32'hFFF38393;
        rom[30] = 32'hFE039CE3;
        rom[31] = 32'hFFF30313;
        rom[32] = 32'hFE0318E3;
        rom[33] = 32'h00008067;
    end

    assign instruction = rom[instAddress[7:2]];

endmodule