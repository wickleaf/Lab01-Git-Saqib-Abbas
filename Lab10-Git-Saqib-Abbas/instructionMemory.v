`timescale 1ns/1ps

module instructionMemory #(
    parameter OPERAND_LENGTH = 31
)(
    input  [OPERAND_LENGTH:0] instAddress,
    output [31:0] instruction
);

    // 32-bit memory array (Word-addressable)
    reg [31:0] rom [0:33];

    initial begin
        // start
        rom[0]  = 32'h1F000113; // li sp, 0x1F0
        rom[1]  = 32'h20000493; // li s1, 0x200 (512)
        rom[2]  = 32'h30000913; // li s2, 0x300 (768)
        rom[3]  = 32'h30400993; // li s3, 0x304 (772)
        
        // INPUT WAITING
        rom[4]  = 32'h0004A023; // sw zero, 0(s1)
        
        // POLL SWITCHES
        rom[5]  = 32'h00092503; // lw a0, 0(s2)
        rom[6]  = 32'hFE050EE3; // beq a0, zero, POLL_SWITCHES
        rom[7]  = 32'h00C000EF; // jal ra, COUNTDOWN_SUB
        rom[8]  = 32'hFF1FF06F; // j INPUT_WAITING
        
        // COUNTDOWN SUB
        rom[9]  = 32'hFF810113; // addi sp, sp, -8
        rom[10] = 32'h00112223; // sw ra, 4(sp)
        rom[11] = 32'h00812023; // sw s0, 0(sp)
        rom[12] = 32'h00050413; // mv s0, a0
        
        // COUNTDOWN LOOP
        rom[13] = 32'h02040263; // beq s0, zero, COUNTDOWN_DONE
        rom[14] = 32'h0009A283; // lw t0, 0(s3)
        rom[15] = 32'h00029A63; // bne t0, zero, RESET_DETECTED
        rom[16] = 32'h0084A023; // sw s0, 0(s1)
        rom[17] = 32'h024000EF; // jal ra, DELAY
        rom[18] = 32'hFFF40413; // addi s0, s0, -1
        rom[19] = 32'hFE9FF06F; // j COUNTDOWN_LOOP
        
        // RESET DETECTED
        rom[20] = 32'h0004A023; // sw zero, 0(s1)
        rom[21] = 32'h0080006F; // j COUNTDOWN_DONE
        
        // COUNTDOWN DONE
        rom[22] = 32'h0004A023; // sw zero, 0(s1)
        rom[23] = 32'h00412083; // lw ra, 4(sp)
        rom[24] = 32'h00012403; // lw s0, 0(sp)
        rom[25] = 32'h00810113; // addi sp, sp, 8
        rom[26] = 32'h00008067; // ret
        
        // DELAY
        rom[27] = 32'h3E800313; // li t1, 1000
        
        // DELAY OUTER
        rom[28] = 32'h1F400393; // li t2, 500
        
        // DELAY INNER
        rom[29] = 32'hFFF38393; // addi t2, t2, -1
        rom[30] = 32'hFE039CE3; // bne t2, zero, DELAY_INNER
        rom[31] = 32'hFFF30313; // addi t1, t1, -1
        rom[32] = 32'hFE0318E3; // bne t1, zero, DELAY_OUTER
        rom[33] = 32'h00008067; // ret
    end

    // The PC address is byte-aligned (0, 4, 8), so we shift right by 2 to get the array index
    assign instruction = rom[instAddress[7:2]];

endmodule
