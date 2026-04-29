`timescale 1ns / 1ps

module instructionMemory #(
    parameter OPERAND_LENGTH = 31,
    parameter MEM_FILE = "countdown.mem"
)(
    input  [OPERAND_LENGTH:0] instAddress,
    output [31:0] instruction
);
    reg [31:0] rom [0:63];
    integer i;

    initial begin
        // Initialize all ROM addresses to 0 to prevent uninitialized 'X' states
        for (i = 0; i < 64; i = i + 1) begin
            rom[i] = 32'h00000000;
        end
        
        // Load the instructions from the memory file
        $readmemh(MEM_FILE, rom);
    end

    // Byte-addressed PC -> word index via address[7:2]
    assign instruction = rom[instAddress[7:2]];

endmodule