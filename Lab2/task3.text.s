.text
.globl main
main:
   addi x22, x0, 0
   addi x23, x0, 0
   addi x24, x0, 9
   li x09, 0x200
   Loop: slli x10, x22,2
   add x10, x10, x09
   sw x22, 0(x10)
   beq x22, x24, Exit
   addi x22, x22,1
   beq x0, x0, Loop
   Exit:
   li x22, 0
   li x10, 0
   LoopTwo: slli x10, x22,2
   add x10, x10, x09
   lw x11, 0(x10)
   add x23, x23, x11
   beq x22, x24, ExitTwo
   addi x22, x22, 1
   beq x0, x0, LoopTwo
   ExitTwo:
   


end:
    j end             # Infinite loop to halt program